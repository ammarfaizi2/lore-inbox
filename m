Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316523AbSEUF6z>; Tue, 21 May 2002 01:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316524AbSEUF6y>; Tue, 21 May 2002 01:58:54 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:45837 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S316523AbSEUF6x>; Tue, 21 May 2002 01:58:53 -0400
Message-Id: <200205210555.g4L5tfY29889@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: AUDIT: copy_from_user is a deathtrap.
Date: Tue, 21 May 2002 08:57:28 -0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <mailman.1021642692.12772.linux-kernel2news@redhat.com> <200205191212.g4JCCLY25867@Port.imtp.ilyichevsk.odessa.ua> <20020520112232.A8983@devserv.devel.redhat.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 May 2002 13:22, you wrote:
> > Can you tell me what's wrong with copy_from_user? How did you used it
> > wrongly?
>
> Denis, I agree with the essense of Rusty's argument, which is that
> copy_to_user is easy to misuse in the following way:
>
> xxx_ioctl (..., cmd, arg) {
> 	return copy_to_user(....);
> }
>
> Since copy_to_user returns a number of residue bytes instead of
> -EINVAL, such statement confuses the caller.
> Rusty found something about 54 instances of this.

Oh. Do you think a pair of

copy_to_user_or_EINVAL(...)
copy_to_user_return_residue(...)

will help avoid such bugs?
It is possible to audit kernel once, move it to new functions
and deprecate/delete old one.
--
vda
