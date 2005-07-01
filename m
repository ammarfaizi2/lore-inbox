Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263218AbVGAHSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263218AbVGAHSG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 03:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263263AbVGAHSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 03:18:06 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:2571 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S263218AbVGAHQ5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 03:16:57 -0400
Message-ID: <42C4EDEA.6020602@slaphack.com>
Date: Fri, 01 Jul 2005 02:16:58 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zan Lynx <zlynx@acm.org>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Hubert Chan <hubert@uhoreg.ca>,
       Hans Reiser <reiser@namesys.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Valdis.Kletnieks@vt.edu, Lincoln Dale <ltd@cisco.com>,
       Gregory Maxwell <gmaxwell@gmail.com>, Jeff Garzik <jgarzik@pobox.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506301847.j5UIlp6u012775@laptop11.inf.utfsm.cl> <1120163870.12258.107.camel@localhost>
In-Reply-To: <1120163870.12258.107.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zan Lynx wrote:
> On Thu, 2005-06-30 at 14:47 -0400, Horst von Brand wrote:
> [snip]
[snip-some-more]
> Structured files are fine when they're small but quickly become
> disgusting as they get bigger.  Either you slowly rewrite the whole
> thing or you "fast save" by writing new sections to the end of it that
> replace existing sections.  That's how you end up with documents that
> contain "deleted" information that was supposed to be confidential.

Doesn't OpenOffice already do something similar with zipfiles?  I 
remember noticing huge differences in save times after adding large 
images to a presentation versus just changing some text.  So, it's 
obviously not repacking each image every time I save.  But, as the 
internal text is all XML, I doubt it's leaving "deleted" sections lying 
around.

> Having the filesystem track each part for you and then creating a
> structured file when needed (and without needing to remember to run a
> special tool) is a far better idea.  (reiser4 doesn't do this but its a
> possible idea)

Been discussed to death, and chances are, Reiser4 will do this with 
plugins.  I imagine it being implemented in a more general way, though. 
  For example, a meta-file which, when read, produces a 
zipfile/tarball/dump of the directory it belongs to.  Then, to send such 
a document via email, you just navigate to the directory where it lives 
while looking for files to attach, only from /meta/vfs as a base, then 
attach the meta-file.  The zipfile gets built automatically.

To simplify the process, all you *really* need is a button on all FS 
navigation windows (Nautilus, Open/Save dialogs, etc) to switch back and 
forth between the meta view and the normal view.  That, or a separate pane.

This way, instead of patching the mail client to support all possible 
transformations you'd want to do before sending, or patching all 
applications to use zip (and any other transformation a user might want 
to do), or forcing the user to run another app, you automatically get 
*all* available transformations, in a way that could potentially look as 
smooth as adding zip support directly to the app.

> Another advantage to file-as-directory is being able to access all the
> file's meta-data through a single channel: file names and text data.
> It removes the need for chmod, chown, touch, getxattr, chacl and all the
> rest of the special tools needed to work with Unix files.  It also makes
> it far easier to add new meta-data in the future, because no new tools
> have to be written to use it.

All good points except the last one.  New tools vs new plugins?  People 
already know how to write the tools...

> So that's two reasons to bother.

That, and the possible paradigm shift.  Navigating to the /meta dir for 
a file could be the commandline equivalent of right-clicking on the file.

Of course, to some people, paradigm shifts are a reason *not* to bother...
