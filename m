Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759842AbWLDFLi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759842AbWLDFLi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 00:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759847AbWLDFLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 00:11:38 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:34538 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1759838AbWLDFLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 00:11:37 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: USB development list <linux-usb-devel@lists.sourceforge.net>
Cc: Greg KH <gregkh@suse.de>, "Lu, Yinghai" <yinghai.lu@amd.com>,
       Stefan Reinauer <stepan@coresystems.de>,
       Peter Stuge <stuge-linuxbios@cdy.org>, linuxbios@linuxbios.org,
       linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: [RFC][PATCH 0/2] x86_64 Early usb debug port support.
References: <5986589C150B2F49A46483AC44C7BCA4907276@ssvlexmb2.amd.com>
	<20061201191916.GB3539@suse.de>
	<m13b7xf084.fsf@ebiederm.dsl.xmission.com>
Date: Sun, 03 Dec 2006 22:09:08 -0700
In-Reply-To: <m13b7xf084.fsf@ebiederm.dsl.xmission.com> (Eric W. Biederman's
	message of "Sun, 03 Dec 2006 08:49:47 -0700")
Message-ID: <m1hcwcuu17.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


With legacy free systems serial ports have stopped being an option
to get early boot traces and other debug information out of a machine.

EHCI USB controllers provide a relatively simple debug interface
that can control port 1 of the root hub.  This interface is limited
to 8 byte packets so it can be used with most USB devices.  But with
a USB debug device this is sufficient to talk to another machine.

When the special feature of the EHCI is not enabled the port
1 of the root hub acts just like any other USB port so machines
with the necessary support are widely available.

This debug device can be used to replace serial ports for
kgdb, kdb, and console support.  And gregkh has a simple usb
serial driver for it so user space applications that control
serial ports should work unmodified.

Currently there only appears to be one manufacturer of debug
devices see:
http://www.plxtech.com/products/NET2000/NET20DC/default.asp

I think simple RS232 serial ports provide a nicer and simpler
interface but the usb debug port looks like a functional alternative
when you don't have that.

My code likely doesn't handle all of the corner cases yet, and needs
a little more work to integrate cleanly into the build.  But this
is getting it out there so other people can look and help make clean
drivers.  When writing a polling driver you do have to be careful
with your logic, because if you do things like reset a usb device at
the wrong time you can completely confuse various EHCI controllers.

My driver should be sufficient to work with any EHCI in a realatively
clean state, and needs no special BIOS support just the hardware.
This appears to be different than the way the windows drivers are
using these debug devices.

Eric

