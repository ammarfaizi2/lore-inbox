Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261216AbUJ3QbA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbUJ3QbA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 12:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbUJ3Qa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 12:30:58 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:22417 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S261216AbUJ3Q1o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 12:27:44 -0400
Subject: Problem with hotplug functions
From: Marcel Holtmann <marcel@holtmann.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sat, 30 Oct 2004 18:28:02 +0200
Message-Id: <1099153682.16247.30.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a little problem with the hotplug functions and in particular
with the one from firmware_class. The problem is that the extra env
variables are not set when hotplug is called. Maybe this is fixed
somewhere, but the lastest Bitkeeper snapshot of the Linus tree is not
working for me.

I see a problem in kobject_hotplug() at lib/kobject_uevent.c:

        if (hotplug_ops->hotplug) {
                /* have the kset specific function add its stuff */
                retval = hotplug_ops->hotplug (kset, kobj,
                                  &envp[i], NUM_ENVP - i, scratch,
                                  BUFFER_SIZE - (scratch - buffer));
                if (retval) {
                        pr_debug ("%s - hotplug() returned %d\n",
                                  __FUNCTION__, retval);
                        goto exit;
                }
        }

        spin_lock(&sequence_lock);
        seq = ++hotplug_seqnum;
        spin_unlock(&sequence_lock);

        envp [i++] = scratch;
        scratch += sprintf(scratch, "SEQNUM=%lld", (long long)seq) + 1;

The hotplug function of hotplug_ops get called, but afterwards its
values are overwritten by the sequence number. Is this correct or do I
made a thinking mistake?

Regards

Marcel


