Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290500AbSBFNT3>; Wed, 6 Feb 2002 08:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290503AbSBFNTT>; Wed, 6 Feb 2002 08:19:19 -0500
Received: from ns.suse.de ([213.95.15.193]:19461 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S290500AbSBFNTJ>;
	Wed, 6 Feb 2002 08:19:09 -0500
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel: ldt allocation failed
In-Reply-To: <Pine.LNX.4.21.0112070057480.20196-100000@tombigbee.pixar.com.suse.lists.linux.kernel> <5.1.0.14.2.20011207092244.049f6720@pop.cus.cam.ac.uk.suse.lists.linux.kernel> <200202061258.g16CwGt31197@Port.imtp.ilyichevsk.odessa.ua.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 06 Feb 2002 14:19:07 +0100
In-Reply-To: Denis Vlasenko's message of "6 Feb 2002 14:09:51 +0100"
Message-ID: <p73ofj2lpdg.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> writes:
> 
> I am ignorant on the subject, but why LDT is used in Linux at all?
> LDT register can be set to 0, this can speed up task switch time and save 
> some memory used for LDT.

glibc thread local data uses an LDT for the segment register.

glibc 2.3 seems to plan to use segment register based thread local data for 
even non threaded programs, so it would be a good idea to optimize LDT 
allocation a bit (= not allocate 64K of vmalloc space every time 
sys_modify_ldt is called - there is only 8MB of it) 

-Andi
