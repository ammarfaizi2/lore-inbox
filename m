Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289118AbSBGTDS>; Thu, 7 Feb 2002 14:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289549AbSBGTC6>; Thu, 7 Feb 2002 14:02:58 -0500
Received: from cm-24-161-45-249.nycap.rr.com ([24.161.45.249]:50817 "EHLO
	incandescent.mp3revolution.net") by vger.kernel.org with ESMTP
	id <S289118AbSBGTCw>; Thu, 7 Feb 2002 14:02:52 -0500
Date: Thu, 7 Feb 2002 14:02:50 -0500
From: Andres Salomon <dilinger@mp3revolution.net>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@zip.com.au>
Subject: Re: D state processes in 2.4.18-pre7-ac3
Message-ID: <20020207190250.GA27081@mp3revolution.net>
In-Reply-To: <20020207090237.GA2137@mp3revolution.net> <3C624782.14FC8C70@zip.com.au> <20020207145356.GA4658@mp3revolution.net> <20020207182925.N2227@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020207182925.N2227@redhat.com>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux incandescent 2.4.18-pre7-ac3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems reproducible, but I'm not sure yet.  I first saw it (it being
D-state processes similar to what I see now; I didn't have sysrq
compiled into the kernel then) happen when I upgraded to -ac2; at the
time, I was using reiserfs on that partition instead of ext3.  I thought
it might be a reiser bug, so I converted it to ext3, and upgraded to -ac3. 
The conversion required a lot of LVM util running; I don't remember how
much time lapsed between finishing the conversion, and processes
hanging.

This leads me to believe it's not ext3, but either lvm or pdc202xx.  Or
something common to ext3(jbd)/reiserfs..



On Thu, Feb 07, 2002 at 06:29:25PM +0000, Stephen C. Tweedie wrote:
> 
> Hi,
> 
> On Thu, Feb 07, 2002 at 09:53:56AM -0500, Andres Salomon wrote:
> > No messages at all, actually.  I noticed my sysrq-t made it into my logs
> > (although it doesn't look all too correct..), so I've included it
> > below.  The D-state processes themselves seem to be the only indication of
> > something gone wrong.  
>  
> >From this:
> 
> > Feb  7 02:30:01 incandescent kernel: bash          D C0079EB0     0 14718  27389          3494 27391 (NOTLB)
> > Feb  7 02:30:01 incandescent kernel: Call Trace: [__wait_on_buffer+106/144] [ipt_MASQUERADE:__insmod_ipt_MASQUERADE_O/lib/modules/2.4.18-pre7-ac3/kerne+-599850/96] [ipt_MASQUERADE:__insmod_ipt_MASQUERADE_O/lib/modules/2.4.18-pre7-ac3/kerne+-608890/96] [do_page_fault+355/1172] [do_page_fault+0/1172] 
> > Feb  7 02:30:01 incandescent kernel:    [vfs_readdir+97/144] [filldir64+0/368] [sys_getdents64+79/259] [filldir64+0/368] [sys_fcntl64+128/144] [system_call+51/56] 
> 
> it looks as if there are other processes stalled on IO too.
> Unfortunately the modules decoding of the call traces looks broken, so
> it's hard from this to really work out what might be the source of
> that particular stall.
> 
> Is this at all reproducible?  Had you been running any LVM utils
> recently?
> 
> --Stephen
> 
> 

-- 
"I think a lot of the basis of the open source movement comes from
  procrastinating students..."
	-- Andrew Tridgell <http://www.linux-mag.com/2001-07/tridgell_04.html>
