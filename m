Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282492AbRLGPrC>; Fri, 7 Dec 2001 10:47:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282664AbRLGPqw>; Fri, 7 Dec 2001 10:46:52 -0500
Received: from sushi.toad.net ([162.33.130.105]:5033 "EHLO sushi.toad.net")
	by vger.kernel.org with ESMTP id <S282492AbRLGPqn>;
	Fri, 7 Dec 2001 10:46:43 -0500
Subject: Re: devfs unable to handle permission: 2.4.17-pre[4,5] /
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 07 Dec 2001 10:47:37 -0500
Message-Id: <1007740060.2031.2.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some devfs permission problems may have arisen because of the
fact that devfs now notifies devfsd of the creation of
directories.  Many people have devfsd configured to set
permissions to all devices matching a certain regular
expression --- e.g., all devices with "sound" in their
pathname.  The problem is that the "sound" directory itself
matches this regular expression, and so will have its perm
bits set exactly like the device files' perm bits---e.g.,
with the eXamine bit cleared.  The solution is to edit the
devfsd config so that it excludes the directory.  E.g.,
instead of:
    REGISTER sound PERMISSIONS root.audio 0664
(which worked before but won't any more) do:
    REGISTER ^sound/.* PERMISSIONS root.audio 0664
or something similar.

Roman Zippel wrote:
> Option 3:
> Turn a user generated entry into a kernel generated
> one and return 0. Prepopulating devfs was a valid
> option so far, you cannot simply change this during
> a stable kernel release.

As Richard has pointed out, devfs is still marked
"experimental", so it's not unreasonable to make changes
if they are improvements.

--
Thomas Hood




