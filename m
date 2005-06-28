Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261340AbVF1UGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbVF1UGr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 16:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbVF1UEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 16:04:20 -0400
Received: from smtpout.mac.com ([17.250.248.73]:47570 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261264AbVF1UAf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 16:00:35 -0400
In-Reply-To: <87d5q6pdyv.fsf@evinrude.uhoreg.ca>
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl> <42BE563D.4000402@cisco.com> <42BE5DB6.8040103@slaphack.com> <200506261816.j5QIGMdI010142@turing-police.cc.vt.edu> <42BF08CF.2020703@slaphack.com> <200506262105.j5QL5kdR018609@turing-police.cc.vt.edu> <42BF2DC4.8030901@slaphack.com> <200506270040.j5R0eUNA030632@turing-police.cc.vt.edu> <42BF667C.50606@slaphack.com> <5284F665-873C-45B7-8DDB-5F475F2CE399@mac.com> <42BF7167.80201@slaphack.com> <EC02A684-815A-4DF8-B5C1-9029FE45E187@mac.com> <42C06D59.2090200@slaphack.com> <CD59AE36-FD15-4A4C-9E1D-AB2F8B52D653@mac.com> <42C08B5E.2080000@slaphack.com> <87y88vrzkg.fsf@evinrude.uhoreg.ca> <EBD8F590-0113-4509-9604-E6967C65C835@mac.com> <87mzpbrvpf.fsf@evinrude.uhoreg.ca> <D3A4ABBF-8062-4399-B1EC-61722295944A@mac.com> <87irzzrqu7.fsf@evinrude.uhoreg.ca> <2B1C058D-C304-4E15-ACDA-C3337E67E981@mac.com> <87d5q6pdyv.fsf@evinrude.uhoreg.ca>
Mime-Version: 1.0 (Apple Message framework v730)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C7DB345A-CD35-4A4C-89F7-5BBD3CB83DF4@mac.com>
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
Date: Tue, 28 Jun 2005 15:59:03 -0400
To: Hubert Chan <hubert@uhoreg.ca>
X-Mailer: Apple Mail (2.730)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 28, 2005, at 13:51:04, Hubert Chan wrote:
> On Tue, 28 Jun 2005 02:01:12 -0400, Kyle Moffett  
> <mrmacman_g4@mac.com> said:
>> I don't disagree with the thumbnail/icon/description, but things like
>> POSIX acls and extended attributes have _existing_ interfaces which
>> should be used.
>
> OK.  I agree with that.  Of course, Reiser4 can always present both
> interfaces, just like it presented two interfaces to the stat data --
> the regular interface and the metas (now '...') interface -- before
> file-as-dir got disabled by default.

Yeah, but let's get the normal interface working first and discuss what
form the alternate one should take

>> I don't deny them the right to add other interfaces later, but such
>> should be a secondary or tertiary patch, after the rest of the stuff
>> is in.  In any case, if we were to provide an interface by which one
>> could $EDITOR the POSIX ACLs, it should be done in the VFS where all
>> filesystems can share it.
>
> I don't know if VFS is the right place for it, but I agree that it  
> would
> be good to make it accessible to all filesystems.

That's somewhat of a contradiction in terms.  The whole point of the VFS
is to hold all of the things that multiple filesystems want to  
share :-D.

>> The key difference here is that Mac OS X does all of the bundle mess
>> in userspace where it belongs. :-D (I know, I use it daily)
>
> Yes.  It's handled by NSWorkspace which is approximately equivalent to
> this sort of thing being handled by GnomeVFS or the KDE  
> equivalent.  Of
> course the problem with handling it in userspace is that behaviour  
> isn't
> uniform -- applications that don't use NSWorkspace (e.g. some
> command-line utils, programs ported over from UNIX, etc.) won't  
> have the
> same behaviour.  Whether or not that is an actual problem seems to be
> debatable.  (I don't use MacOS X, but I've done some programming in
> GNUstep.)

Personally, I think that the multiple views is a good thing.  I like
being able to "cd /Applications/Games/UnrealTournament2004.app/System"
and mess with my game files, while double-clicking it in the Finder
just starts it so I can get on with owning my friends :-D.

> Another problem is that it only works with bundle files.  e.g. I can't
> add an icon to a regular txt file.  Tiger now supports xattrs,  
> which you
> could use for that functionality, but then we run into the problem  
> again
> of not being able to edit it with regular applications.

Maybe we just need better regular applications?  I think that for the
icon case, for the Samba/streams case, and for many others I'm probably
forgetting, we should try to come up with a new "data-stream" VFS API,
so that the icon data and other larger quantities can be stored in a
filesystem without much effort.  Such a layer could even be bridged
onto existing filesystems via a VFS-wrapper bind-mount:

# mount -t reiser4 /dev/hda1 /mnt1

# mount -t ext3 /dev/hda2 /mnt2

# cat $(metapath /mnt1/foo)/streams/description
Some random file

# cat $(metapath /mnt2/foo)/streams/description
cat: Unsupported operation

# mount -t none -o bind,streamify /mnt2 /mnt3

# cat $(metapath /mnt3/foo)/streams/description
Another random file

Such a wrapper interface might use the directory '...' to store files on
the underlying filesystem, but I don't think that the meta interface
itself should use those directories.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$  
r  !y?(-)
------END GEEK CODE BLOCK------

