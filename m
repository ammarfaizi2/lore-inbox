Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315833AbSEEIRI>; Sun, 5 May 2002 04:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315834AbSEEIRH>; Sun, 5 May 2002 04:17:07 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:4869 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S315833AbSEEIRG>;
	Sun, 5 May 2002 04:17:06 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
Cc: Eyal Lebedinsky <eyal@eyal.emu.id.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre8aa2 
In-Reply-To: Your message of "Sun, 05 May 2002 18:04:41 +1000."
             <4003.1020585881@ocs3.intra.ocs.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 05 May 2002 18:16:56 +1000
Message-ID: <4297.1020586616@ocs3.intra.ocs.com.au>
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 05 May 2002 18:04:41 +1000, 
Keith Owens <kaos@ocs.com.au> wrote:
>On Sun, 05 May 2002 17:40:56 +1000, 
>Eyal Lebedinsky <eyal@eyal.emu.id.au> wrote:
>>You are right, it is not the unresolved that caused it but the non
>>ELF objects in there (it used not to care before):
>>
>># /sbin/depmod-2.4.15 -ae ; echo $?
>>depmod: /lib/modules/2.4.19-pre8-aa2/ksyms is not an ELF file
>>depmod: /lib/modules/2.4.19-pre8-aa2/soundconf is not an ELF file
>>1
>
>All versions of depmod for 2.4 have always returned errors for invalid
>objects in /lib/modules, that check has not changed since modutils
>2.4.0.  modutils has not changed, somebody is storing extra text files
>in /lib/modules without telling modutils.  Don't do that.

My apologies, this is an unexpected side effect of a change in modutils
2.4.13.  Christian Lademann asked that depmod do as much work as
possible instead of exiting early.  That meant checking the error count
at the end of depmod and giving a non-zero return if any errors were
detected.  depmod before 2.4.13 ignored the return code from the
loadobj() function, with the 2.4.13 change the ignored error flag was
being used.

I will revert to ignoring the loadobj() return code for error purposes
in modutils 2.4.17.  The behavior is wrong but it is what people
expect.

