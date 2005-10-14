Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932140AbVJNJGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbVJNJGb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 05:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbVJNJGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 05:06:31 -0400
Received: from rs1.theo-phys.uni-essen.de ([132.252.73.3]:6816 "EHLO
	rs1.Theo-Phys.Uni-Essen.DE") by vger.kernel.org with ESMTP
	id S1751214AbVJNJGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 05:06:30 -0400
Message-Id: <200510140905.LAA10947@next12.theo-phys.uni-essen.de>
Content-Type: text/plain
MIME-Version: 1.0 (NeXT Mail 4.2mach_patches v148.2)
X-Nextstep-Mailer: Mail 4.2mach_patches [i386] (Enhance 2.2p3, May 2000)
From: Ruediger Oberhage <ruediger@next12.theo-phys.uni-essen.de>
Date: Fri, 14 Oct 2005 11:05:35 +0200
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: NFS client problem with kernel 2.6 and SGI IRIX 6.5
cc: linux-kernel@vger.kernel.org, 325117@bugs.debian.org,
       ruediger@theo-phys.uni-essen.de
Reply-To: ruediger@theo-phys.uni-essen.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Trond Myklebust,

my name is Ruediger Oberhage, I'm (amongst other duties)
administering computers for the Theoretical Physics in Essen of
the university Duisburg-Essen, Germany, and I do have a (client)
problem (severe to us) with the 2.6 kernel series and nfs, when
served from an SGI IRIX 6.5 system (type: Origin 200).

Since I use the Debian GNU/Linux distribution, I contacted its kernel
maintainer (Horms) first, and he pointed me to you (I'll add the
problem report(s) below).

The problem was registered with the Debian Bug Tracking System as
Bug#325117.

The summary is as follows: I do have problems with the 2.6 series
kernel, which do not occur with a 2.4 series kernel (and an other-
wise unchanged system). I discovered it with Mathematica version 5.0,
but do think that other programs are also involved (e.g. OpenOffice
1.1.4, that doesn't find its default (or any other) printer any
longer). The symptom is, that certain ressources are reported
missing, that are definitively there and which lie somewhere
within the application-tree, that tree lying within a hierarchie
being nfs-auto-mounted from the SGI system to the (Intel architec-
ture) Linux client. File contents (or whole files?) seems to get  
'lost' somehow.

It doesn't seem to be the MSBit Problem of the 32bit nfs cookies
(alone) - the branch is exported with the IRIX '32bitclients'
option, to avoid the 64bit cookies, that led to a similar problem
with the printer in OpenOffice under the 2.4 series kernels, and
vanished with the 32bit-option.  The reason for me to state this
is, that when I applied a 32bit-'SGI-IRIX-induced'-patch for (early)
2.6 kernels (Debians 2.6.8) the problem didn't go away, and it also
still occurs when using the 2.6.12-kernel, where some kernel-version
ago (2.6.10 or 11?) that part of the cookie problem was solved via a  
translation table (once and for all, I hope).

The problem occurs when requesting nfs v2 as well as nfs v3 protocol.
An LD_ASSUME_KERNEL does not seem to help, as it does with other
problems.

When testing or compiling kernels, I always used the 'debianized'
versions, but to my understanding, they are nearly unaltered compared
to the 'plain' kernels (see Debian changelogs).

The problem is severe to us, as the same configuration also exports
our home-directories, which are, of course, writeable, contrary to
the application-tree, which is read-only. Thus any help will be
welcome.

I'm willing to try whatever I can do to resolve the problem, but I
need guidance in what to do and what (else) you need to know.

Many thanks,
 Ruediger Oberhage

Please find the 'Debian bug reports and replies' below
(sorry, it's long, but you may skip it should you prefer to
 get it from Debian's Bug Tracking System directly!):

Package: kernel-image-2.6.8-2-686
Version: 2.6.8-16

Severity: critical

Hello!

This is about an (at least to us) critical bug within NFS in the
current Debian 3.1 (stable=sarge) version Intel i386 architecture
with kernel 2.6 only! All the phaenomena reported do not(!) occur
with kernel 2.4 (here 2.4.27, more precisely 2.4.27-2-686).

First symptom: when I change into any NFS-mounted directory or
subdirectory thereof and issue the command 'find . -print', I get
the following result:

/Net/Apps# find . -print
.
find: .: Value too large for defined data type

The same is true, if I address that directory 'from the outside':

/tmp# find /Net/Apps/. -print
/Net/Apps/.
find: /Net/Apps/.: Value too large for defined data type

[the '.' after the /Net/Apps/ is necessary, as this is a
 symlink here! But the same happens, when that is not the
 case!]

I've read about such a problem in the Ubuntu bug-tracking
system, and they claim to have a solution for this one.
This could be true, as this problem doesn't show, when I
use the Knoppix 4.0 DVD (which uses a 2.6.12-kernel, iirc).
I did compile and try under 'sarge' the latest kernel available
in the Debian repository at this time (2.6.11-7) from
kernel-source-2.6.11_2.6.11-7_all.deb and accessories via
'make-kpkg', a 'sarge'-version of
"kernel-image-2.6.11-1-686_2.6.11-7_i386.deb" so to speak,
and this one, too, shows the error. So it isn't gone in
Debian!
libc6 is: Version: 2.3.2.ds1-22, the 'standard one', but
I don't think, it does matter.
[As written above, it doesn't show up with kernel 2.4!]


The second problem is the critical failure of applications
in such an NFS-mounted tree. E.g. Mathematica v5.0 crashes,
with a 'segmentation fault', after not only complaining about
problems with "fonts" (that can often be ignored), but
also with reporting missing 'structures' (read files!) from
that tree, finally resulting in the abort. These files are
definitely there and not 'harmed' - it does work with a 2.4 kernel
and an otherwise unchanged 'sarge' system. [An LD_ASSUME_KERNEL=2.4
does not(!) help here for 2.6 kernels, as it does with e.g.
Maple v.8, where a missing 'errno' variable is (otherwise) reported
for libc6 by the dynamic linker with 2.6 kernels.]

This problem does not(!) go away with the KNOPPIX 4.0 DVD kernel
version, contrary to the 'find'-problem!

Also playing around with every parameter of the NFS-system (like
NFS-version (2 or 3), tcp, r/wsize etc.) that makes sense to me, did
not result in a working system.

The server(s) here is (are) Origin 200 SGI IRIX 6.5 system(s) with
xfs filesystems! But I don't think this matters, either, see the
'Ubuntu'-problem report. Linux servers might work, though, by
canceallation of errors in server and client.

I don't dare to use such a combination on the 'writable' NFS-home-
directories of our users, for fear of destroying files [the 'apps'
are mounted read-only (ro) and are not a problem in this regard].

As this concerns the (NFS-mounted) applications as well as the
home-directories of our users, I regard this problem as critical!
Thus the severity rating! It is probably less severe for someone
not using 'NFS' or using 'Linux only' systems - where I can't
say, if the problem arises. The only workaround for me is to use a
2.4 kernel, which isn't nice - udev/hal and other component highly
advisable for a desktop system (e.g. for USB-memory-sticks. other
removable media etc.) are not available then!

With the plea for a fast fix and best regards,
 Ruediger Oberhage

-----

On Fri, Aug 26, 2005 at 10:52:06AM +0200, Ruediger Oberhage wrote:
> Package: kernel-image-2.6.8-2-686
> Version: 2.6.8-16
>
> Severity: critical

Hi,

is it possible for you to test the 2.6.12 kernel package
that has been produced for Sarge. Its available at the
following URL as 2.6.12-5.99

It would be good to know if the problem was fixed between
2.6.8 and 2.6.12. If not I would recommend starting a dialog
with the upstream NFS maintainers, I can point you to the right place.
If so, we have a starting point to try and isolate the change
that resolve the problem. Though it may prove too extensive
to be appropriate for backporting to 2.6.8.

Regards

-----

> Hi,

Hello,

many thanks for your kind reply.

> is it possible for you to test the 2.6.12 kernel package
> that has been produced for Sarge. Its available at the
> following URL as 2.6.12-5.99

Well, I did try some packages mentioned to be available on
http://packages.vergenet.net/testing/linux-2.6/
[linux-image-2.6.12-1-686_2.6.12-5.99.sarge1_i386.deb and
 dependancies] and they didn't work, either, or more precisely showed
the same symptom.
[This and a patch I found for the MSB-problem of the 32bit
 cookies (or even 64bit cookies without export-option) for which
 SGI IRIX 6(.5) is notorius for and which I applied to earlier 2.6er
 kernels seem to indicate, that the problem hasn't vanished in
 between and is not related to (only) the 32bit nfs-cookie thing.
 I'm not sure if I mentioned that in the original message.]

> It would be good to know if the problem was fixed between
> 2.6.8 and 2.6.12.

I don't think so (see above).

> If not I would recommend starting a dialog with the upstream NFS
> maintainers, I can point you to the right place.

That would be nice thank you. I'm willing to try everything that
I'm carefully guided to :-), as long as my resources allow.
Since it is important to me for this to work, I'd like to help
where I can.

> If so, we have a starting point to try and isolate the change
> that resolve the problem. Though it may prove too extensive
> to be appropriate for backporting to 2.6.8.

Yes, I do understand this, and I would gladly be willing to
switch to a newer kernel. 2.6.8 is a non-optimal choice anyway
in my eyes, being the last kernel which has practically no
useful (udev) classes but the most general (e.g. the 'dvb' class
is still missing from its modules/drivers).

Thus it wouldn't be that hard for me to part with 2.6.8, but
a transition beyond 2.6.12 (e.g. 2.6.13) with 'sarge' might
be hard (or impossible?), too, regarding its 'tools' dependancies.

The most important thing would be, to learn what's going wrong
with 'nfs', though, I think. At least to me and may be to you, too.

Thanks again and regards,
 Ruediger Oberhage

-----

tag 325117 +upstream
thanks

On Fri, Oct 07, 2005 at 09:11:56AM +0200, Ruediger Oberhage wrote:
> > Hi,
>
> Hello,
>
> many thanks for your kind reply.
>
> > is it possible for you to test the 2.6.12 kernel package
> > that has been produced for Sarge. Its available at the
> > following URL as 2.6.12-5.99
>
> Well, I did try some packages mentioned to be available on
> http://packages.vergenet.net/testing/linux-2.6/
> [linux-image-2.6.12-1-686_2.6.12-5.99.sarge1_i386.deb and
>  dependancies] and they didn't work, either, or more precisely showed
> the same symptom.
> [This and a patch I found for the MSB-problem of the 32bit
>  cookies (or even 64bit cookies without export-option) for which
>  SGI IRIX 6(.5) is notorius for and which I applied to earlier 2.6er
>  kernels seem to indicate, that the problem hasn't vanished in
>  between and is not related to (only) the 32bit nfs-cookie thing.
>  I'm not sure if I mentioned that in the original message.]
>
> > It would be good to know if the problem was fixed between
> > 2.6.8 and 2.6.12.
>
> I don't think so (see above).

Yes I agree

> > If not I would recommend starting a dialog with the upstream NFS
> > maintainers, I can point you to the right place.
>
> That would be nice thank you. I'm willing to try everything that
> I'm carefully guided to :-), as long as my resources allow.
> Since it is important to me for this to work, I'd like to help
> where I can.

As I understand your problem seems to be with the NFS client,
not the NFS server portion of the kernel. The contact for
that is Trond Myklebust <trond.myklebust@fys.uio.no>, you
should also CC linux-kernel@vger.kernel.org.

If you see anything related to this message in dmsg, send that too.

On the Debian side, it would be good to CC 325117@bugs.debian.org,
to keep this bug up to date. Upstream lives on CC, so it
probably won't drop off in a hurry.

> > If so, we have a starting point to try and isolate the change
> > that resolve the problem. Though it may prove too extensive
> > to be appropriate for backporting to 2.6.8.
>
> Yes, I do understand this, and I would gladly be willing to
> switch to a newer kernel. 2.6.8 is a non-optimal choice anyway
> in my eyes, being the last kernel which has practically no
> useful (udev) classes but the most general (e.g. the 'dvb' class
> is still missing from its modules/drivers).
>
> Thus it wouldn't be that hard for me to part with 2.6.8, but
> a transition beyond 2.6.12 (e.g. 2.6.13) with 'sarge' might
> be hard (or impossible?), too, regarding its 'tools' dependancies.
>
> The most important thing would be, to learn what's going wrong
> with 'nfs', though, I think. At least to me and may be to you, too.

--
H.-R. Oberhage
Mail: Univ. Duisburg-Essen	E-Mail:	oberhage@Uni-Essen.DE
      Fachbereich Physik		ruediger@Theo-Phys.Uni-Essen.DE
      Campus Essen, S05 V07 E88
      Universitaetsstrasse 5	Phone:  {+49|0} 201 / 183-2493
      45141 Essen, Germany	FAX:    {+49|0} 201 / 183-4578
