Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282876AbRK0Iup>; Tue, 27 Nov 2001 03:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282880AbRK0Iud>; Tue, 27 Nov 2001 03:50:33 -0500
Received: from web9207.mail.yahoo.com ([216.136.129.40]:61714 "HELO
	web9207.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S282876AbRK0Itf>; Tue, 27 Nov 2001 03:49:35 -0500
Message-ID: <20011127084934.11076.qmail@web9207.mail.yahoo.com>
Date: Tue, 27 Nov 2001 00:49:34 -0800 (PST)
From: Alex Davis <alex14641@yahoo.com>
Subject: Re: 2.4.16 alsa 0.5.12 mixer ioctl problem
To: riesen@synopsys.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yeah, they changed/broke (depending on your point of view) the file fs/proc/inode.c in the kernel
source.
You're the third person to post about this problem.

There's a work-around for the problem. (I'm currently running ALSA 0.9beta9, so the file contents
may not exactly match up): in the ALSA driver source, edit the file kernel/info.c. Look for the
following lines

if (p) {
	snd_info_device_entry_prepare(p,entry);
#ifdef LINUX_2_3
	p->proc_fops = &snd_fops;
#else
	p->ops = &snd_info_device_inode_operations;
#endif
	} else {
		up(&info_mutex);
		snd_info_free_entry(entry);
		return NULL;
	}
}

they should be near line 890 or so.

Next, comment out the line 
	p->proc_fops = &snd_fops;

Rebuild. Everything should work now.

Hope this helps.
-Alex

Alex Reisen wrote
Hi, all

just tried to compile the mentioned alsa drivers under 2.4.16. Mixer doesnt work, yes. It
compiles, installs, loads. And
any program trying to open mixer (through libasound) get EINVAL.

All is compiled with gcc-2.95.3,
single CPU, with APIC (is any sense to enable it on
uniprocessors?).

Does anybody know what to do about it?

-alex

__________________________________________________
Do You Yahoo!?
Yahoo! GeoCities - quick and easy web site hosting, just $8.95/month.
http://geocities.yahoo.com/ps/info1
