Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261512AbVF1G1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261512AbVF1G1U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 02:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261424AbVF1G1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 02:27:08 -0400
Received: from smtpout.mac.com ([17.250.248.85]:30918 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261512AbVF1GCU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 02:02:20 -0400
In-Reply-To: <87irzzrqu7.fsf@evinrude.uhoreg.ca>
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl> <42BE3645.4070806@cisco.com> <e692861c05062522071fe380a5@mail.gmail.com> <42BE563D.4000402@cisco.com> <42BE5DB6.8040103@slaphack.com> <200506261816.j5QIGMdI010142@turing-police.cc.vt.edu> <42BF08CF.2020703@slaphack.com> <200506262105.j5QL5kdR018609@turing-police.cc.vt.edu> <42BF2DC4.8030901@slaphack.com> <200506270040.j5R0eUNA030632@turing-police.cc.vt.edu> <42BF667C.50606@slaphack.com> <5284F665-873C-45B7-8DDB-5F475F2CE399@mac.com> <42BF7167.80201@slaphack.com> <EC02A684-815A-4DF8-B5C1-9029FE45E187@mac.com> <42C06D59.2090200@slaphack.com> <CD59AE36-FD15-4A4C-9E1D-AB2F8B52D653@mac.com> <42C08B5E.2080000@slaphack.com> <87y88vrzkg.fsf@evinrude.uhoreg.ca> <EBD8F590-0113-4509-9604-E6967C65C835@mac.com> <87mzpbrvpf.fsf@evinrude.uhoreg.ca> <D3A4ABBF-8062-4399-B1EC-61722295944A@mac.com> <87irzzrqu7.fsf@evinrude.uhoreg.ca>
Mime-Version: 1.0 (Apple Message framework v730)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2B1C058D-C304-4E15-ACDA-C3337E67E981@mac.com>
Cc: David Masover <ninja@slaphack.com>, Valdis.Kletnieks@vt.edu,
       Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Hans Reiser <reiser@namesys.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: reiser4 plugins
Date: Tue, 28 Jun 2005 02:01:12 -0400
To: Hubert Chan <hubert@uhoreg.ca>
X-Mailer: Apple Mail (2.730)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 28, 2005, at 01:30:08, Hubert Chan wrote:
> On Tue, 28 Jun 2005 00:38:38 -0400, Kyle Moffett  
> <mrmacman_g4@mac.com> said:
>> Ok.  Those things should probably be divided up.  Stuff like POSIX
>> extended attributes and such that have existing interfaces should use
>> those.
>
> One of the claimed advantages of the '...' interface is that  
> everything
> is editable as a file.  So if someone wanted to edit the description
> extended attribute for foo.txt, he would just run
> "[editor] foo.txt/.../description" (or
> "[editor] /meta/fs/$(getattrpath foo.txt)/description"), instead of
> needing to use some special purpose editor.  It works well for things
> like being able to use Gimp to edit a thumbnail or icon attribute.

I don't disagree with the thumbnail/icon/description, but things like
POSIX acls and extended attributes have _existing_ interfaces which
should be used.  I don't deny them the right to add other interfaces
later, but such should be a secondary or tertiary patch, after the
rest of the stuff is in.  In any case, if we were to provide an
interface by which one could $EDITOR the POSIX ACLs, it should be
done in the VFS where all filesystems can share it.

> The inspiration, I think, was the MacOS X/NeXTSTEP bundle format.  For
> example, MacOS X/NeXTSTEP .app file is actually a directory that  
> behaves
> much like an executable file (double-clicking a .app file in the  
> Finder
> launches the application, instead of opening the directory).  However,
> it is in reality a directory that contains many things that could be
> thought of as extended attributes (such as the application icon,
> information about the application, etc.).  Since the application  
> icon is
> a real file, it can be edited by normal graphics editors (not like
> Windows programs, where you need a special icon editor).  And since  
> it's
> inside the .app directory, it's attached to the application (not like
> Linux, where the program is in /usr/bin, and the icon is in
> /usr/share/pixmaps), so it makes package management easier (to  
> delete an
> application, just delete the .app file -- don't need to look in
> /usr/share/pixmaps for the icon and delete it).

The key difference here is that Mac OS X does all of the bundle mess
in userspace where it belongs. :-D  (I know, I use it daily)  I think
that part of Reiser4 needs more review than it's been given at present.

Cheers,
Kyle Moffett

--
There are two ways of constructing a software design. One way is to  
make it so simple that there are obviously no deficiencies. And the  
other way is to make it so complicated that there are no obvious  
deficiencies.
  -- C.A.R. Hoare

