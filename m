Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278932AbRKSO7N>; Mon, 19 Nov 2001 09:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278940AbRKSO7D>; Mon, 19 Nov 2001 09:59:03 -0500
Received: from [195.66.192.167] ([195.66.192.167]:34311 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S278932AbRKSO66>; Mon, 19 Nov 2001 09:58:58 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: James A Sutherland <jas88@cam.ac.uk>, linux-kernel@vger.kernel.org
Subject: Re: x bit for dirs: misfeature?
Date: Mon, 19 Nov 2001 16:58:38 +0000
X-Mailer: KMail [version 1.2]
In-Reply-To: <01111916225301.00817@nemo> <E165pWu-0000Pi-00@mauve.csi.cam.ac.uk>
In-Reply-To: <E165pWu-0000Pi-00@mauve.csi.cam.ac.uk>
MIME-Version: 1.0
Message-Id: <01111916583804.00817@nemo>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 November 2001 14:36, James A Sutherland wrote:
> On Monday 19 November 2001 4:22 pm, vda wrote:
> > Everytime I do 'chmod -R a+rX dir' and wonder are there
> > any executables which I don't want to become world executable,
> > I think "Whatta hell with this x bit meaning 'can browse'
> > for dirs?! Who was that clever guy who invented that? Grrrr"
> >
> > Isn't r sufficient? Can we deprecate x for dirs?
> > I.e. make it a mirror of r: you set r, you see x set,
> > you clear r, you see x cleared, set/clear x = nop?
> >
> > Benefits:
> > chmod -R go-x dir (ensure there is no executables)
> > chmod -R a+r dir (make tree world readable)
> > mount -t vfat -o umask=644 /dev/xxx dir
> > 	(I don't want all files to be flagged as executables there)
> >
> > These commands will do what I want without (sometimes ugly) tricks.
> > For mount, I can't even see how to do it with current implementation.
> >
> > What standards will be broken?
> > Any real loss of functionality apart from compat issues?

> The R and X bits on directories have different meanings. Watch:

I know. I'd like to hear anybody who have a directory with r!=x
on purpose (and quite curious on that purpose). UNIX gugus, anybody?

> $ mkdir test
> $ echo content > test/file
> $ chmod a-r test
> $ ls test
> ls: test: permission denied
> $ cat test/file
> content
> $ chmod a=r test
> $ ls test
> ls: test/file: Permission denied

Hmm... I do actually tested this and last command succeeds
(shows dir contents). You probably meant cat test/file, not ls...

> In short, the X bit allows you to access the contents of the directory,
> while R allows you to LIST those contents. There are valid uses for X only
> directories (i.e. users are not allowed to list the contents, only to
> access them directly by name). R-only directories make little sense, as you
> can see from the transcript above :)
