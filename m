Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129826AbRBWUv7>; Fri, 23 Feb 2001 15:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129849AbRBWUvu>; Fri, 23 Feb 2001 15:51:50 -0500
Received: from mail17.bigmailbox.com ([209.132.220.48]:29702 "EHLO
	mail17.bigmailbox.com") by vger.kernel.org with ESMTP
	id <S129826AbRBWUve>; Fri, 23 Feb 2001 15:51:34 -0500
Date: Fri, 23 Feb 2001 12:51:05 -0800
Message-Id: <200102232051.MAA18803@mail17.bigmailbox.com>
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: binary
X-Mailer: MIME-tools 4.104 (Entity 4.116)
Mime-Version: 1.0
X-Originating-Ip: [198.147.65.9]
From: "Quim K Holland" <qkholland@my-deja.com>
To: dledford@redhat.com
Cc: hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: cpu_has_fxsr or cpu_has_xmm?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "DL" == Doug Ledford <dledford@redhat.com> writes:
>> > --- linux.vanilla/arch/i386/kernel/i387.c       Thu Feb 22 09:05:35 2001
>> > +++ linux.ac/arch/i386/kernel/i387.c    Sun Feb  4 10:58:36 2001
>> > @@ -179,7 +179,7 @@
>> >
>> >  unsigned short get_fpu_mxcsr( struct task_struct *tsk )
>> >  {
>> > -       if ( cpu_has_fxsr ) {
>> > +       if ( cpu_has_xmm ) {
>> >                 return tsk->thread.i387.fxsave.mxcsr;
>> >         } else {
>> >                 return 0x1f80;
>> >

DL> As to the correctness, the mxcsr register really only exists
DL> if you have xmm, so the xmm is the correct test. However,...

DL> ...  User space programmers should be checking for xmm
DL> capability themselves before ever paying attention to mxcsr
DL> anyway, so it's not an end of the world error.

If that is the case, wouldn't it be simpler to always return
tsk->thread.i387.fxsave.mxcsr from this function, and initialize
that field to 0x1f80 (whatever that magic number means) when
the structure is built?


------------------------------------------------------------
--== Sent via Deja.com ==--
http://www.deja.com/


