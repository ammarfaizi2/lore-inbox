Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278381AbRKSOgm>; Mon, 19 Nov 2001 09:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279462AbRKSOgc>; Mon, 19 Nov 2001 09:36:32 -0500
Received: from mauve.csi.cam.ac.uk ([131.111.8.38]:64753 "EHLO
	mauve.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S278381AbRKSOg1>; Mon, 19 Nov 2001 09:36:27 -0500
Content-Type: text/plain; charset=US-ASCII
From: James A Sutherland <jas88@cam.ac.uk>
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>, linux-kernel@vger.kernel.org
Subject: Re: x bit for dirs: misfeature?
Date: Mon, 19 Nov 2001 14:36:18 +0000
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <01111916225301.00817@nemo>
In-Reply-To: <01111916225301.00817@nemo>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E165pWu-0000Pi-00@mauve.csi.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 November 2001 4:22 pm, vda wrote:
> Everytime I do 'chmod -R a+rX dir' and wonder are there
> any executables which I don't want to become world executable,
> I think "Whatta hell with this x bit meaning 'can browse'
> for dirs?! Who was that clever guy who invented that? Grrrr"
>
> Isn't r sufficient? Can we deprecate x for dirs?
> I.e. make it a mirror of r: you set r, you see x set,
> you clear r, you see x cleared, set/clear x = nop?
>
> Benefits:
> chmod -R go-x dir (ensure there is no executables)
> chmod -R a+r dir (make tree world readable)
> mount -t vfat -o umask=644 /dev/xxx dir
> 	(I don't want all files to be flagged as executables there)
>
> These commands will do what I want without (sometimes ugly) tricks.
> For mount, I can't even see how to do it with current implementation.
>
> What standards will be broken?
> Any real loss of functionality apart from compat issues?

The R and X bits on directories have different meanings. Watch:

$ mkdir test
$ echo content > test/file
$ chmod a-r test
$ ls test
ls: test: permission denied
$ cat test/file
content
$ chmod a=r test
$ ls test
ls: test/file: Permission denied


In short, the X bit allows you to access the contents of the directory, while 
R allows you to LIST those contents. There are valid uses for X only 
directories (i.e. users are not allowed to list the contents, only to access 
them directly by name). R-only directories make little sense, as you can see 
from the transcript above :)


James.
