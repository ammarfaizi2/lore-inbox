Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932374AbVKLPX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbVKLPX0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 10:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932395AbVKLPX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 10:23:26 -0500
Received: from smtp104.sbc.mail.re2.yahoo.com ([68.142.229.101]:55420 "HELO
	smtp104.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932374AbVKLPXZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 10:23:25 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: =?iso-8859-1?q?Bj=F8rn_Mork?= <bmork@dod.no>
Subject: Re: Resume from swsusp stopped working with 2.6.14 and 2.6.15-rc1
Date: Sat, 12 Nov 2005 10:23:22 -0500
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@suse.cz>
References: <87zmoa0yv5.fsf@obelix.mork.no>
In-Reply-To: <87zmoa0yv5.fsf@obelix.mork.no>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200511121023.23245.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 12 November 2005 08:39, Bjørn Mork wrote:
> I have had swsusp working for ages on a IBM Thinkpad T42, but since
> 2.6.14 it hasn't been willing to resume anymore.  Both suspending to
> disk and ACPI S3 still works. 
> 
> Output of dmesg below (running 2.6.15-rc1). Notice the line:
> 
>   Restarting tasks...<6> Strange, kseriod not stopped
> 
> I guess that's the explanation.  Could it be the new TrackPoint
> driver, maybe?  (This PC has both a TrackPoint and a Touchpad).
>

This is unlikely... serio has the proper support for freezing as
far as I understand:

static int serio_thread(void *nothing)
{
        do {
                serio_handle_events();
                wait_event_interruptible(serio_wait,
                        kthread_should_stop() || !list_empty(&serio_event_list));
                try_to_freeze();
        } while (!kthread_should_stop());

        printk(KERN_DEBUG "serio: kseriod exiting\n");
        return 0;
}

Pavel, any ideas?

-- 
Dmitry
