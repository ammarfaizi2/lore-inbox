Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263830AbTKXRzg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 12:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263832AbTKXRzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 12:55:36 -0500
Received: from hosting-agency.de ([195.69.240.23]:56511 "EHLO mailagency.de")
	by vger.kernel.org with ESMTP id S263830AbTKXRz0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 12:55:26 -0500
From: Jakob Lell <jlell@JakobLell.de>
To: root@chaos.analogic.com
Subject: Re: hard links create local DoS vulnerability and security problems
Date: Mon, 24 Nov 2003 18:57:41 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <200311241736.23824.jlell@JakobLell.de> <Pine.LNX.4.53.0311241205500.18425@chaos>
In-Reply-To: <Pine.LNX.4.53.0311241205500.18425@chaos>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311241857.41324.jlell@JakobLell.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello
On Monday 24 November 2003 18:14, Richard B. Johnson wrote:
> On Mon, 24 Nov 2003, Jakob Lell wrote:
> > Hello,
> > on Linux it is possible for any user to create a hard link to a file
> > belonging to another user. This hard link continues to exist even if the
> > original file is removed by the owner. However, as the link still belongs
> > to the original owner, it is still counted to his quota. If a malicious
> > user creates hard links for every temp file created by another user, this
> > can make the victim run out of quota (or even fill up the hard disk).
> > This makes a local DoS attack possible.
>
> You can create hard-links to any file that a user has given you
> permission to read or execute. This is correct. The new hard-link
> still belongs to the original user, which is also correct.
No. You need neither read nor execute permission to create a hard link.
>
> To prevent this, a user can set his default permissions so that
> neither group nor world can read the files. This is usually done
> by setting the attributes in the user's top directory.
Even if you needed read or execute permissions to create hard link, this isn't 
always possible. Some files have to be world readable.
>
> > Furthermore, users can even create links to a setuid binary. If there is
> > a security whole like a buffer overflow in any setuid binary, a cracker
> > can create a hard link to this file in his home directory. This link
> > still exists when the administrator has fixed the security whole by
> > removing or replacing the insecure program. This makes it possible for a
> > cracker to keep a security whole open until an exploit is available. It
> > is even possible to create links to every setuid program on the system.
> > This doesn't create new security wholes but makes it more likely that
> > they are exploited.
>
> A setuid binary created with a hard-link will only work as a setuid
> binary if the directory it's in is owned by root. If you have users
> that can create files or hard-links within such directories, you
> have users who either know the root password already or have used
> some exploit to become root. In any case, it's not a hard-link
> problem
Setuid-root binaries also work in a home directory.
You can try it by doing this test:
ln /bin/ping $HOME/ping
$HOME/ping localhost
>
> > To solve the problem, the kernel shouldn't allow users to create hard
> > links to
> > files belonging to someone else.
>
> No. Users must be able to create hard links to files that belong
> to somebody else if they are readable. It's a requirement.
If this is REALLY neccessary, it might be possible to prevent hard links to 
setuid binaries.
Regards
 Jakob


