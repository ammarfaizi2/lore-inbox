Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285049AbRLKNso>; Tue, 11 Dec 2001 08:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285035AbRLKNsi>; Tue, 11 Dec 2001 08:48:38 -0500
Received: from chunnel.redhat.com ([199.183.24.220]:19952 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S285052AbRLKNs0>; Tue, 11 Dec 2001 08:48:26 -0500
Date: Tue, 11 Dec 2001 13:47:58 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Nathan Scott <nathans@sgi.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Andreas Gruenbacher <ag@bestbits.at>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: [PATCH] Revised extended attributes interface
Message-ID: <20011211134758.F2268@redhat.com>
In-Reply-To: <20011205143209.C44610@wobbly.melbourne.sgi.com> <20011207202036.J2274@redhat.com> <20011208155841.A56289@wobbly.melbourne.sgi.com> <20011210115209.C1919@redhat.com> <20011211124115.E70201@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011211124115.E70201@wobbly.melbourne.sgi.com>; from nathans@sgi.com on Tue, Dec 11, 2001 at 12:41:15PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Tue, Dec 11, 2001 at 12:41:15PM +1100, Nathan Scott wrote:
> On Mon, Dec 10, 2001 at 11:52:09AM +0000, Stephen C. Tweedie wrote:

> > Unfortunately, if there are many filesystems wanting to use posix
> > ACLs, then standardising the API is still desirable.
 
> Yes, absolutely.  That is in fact a large driving force behind
> this effort to get a common EA and POSIX ACL API, and we are now
> for the first time at a point where we have multiple filesystems
> (xfs, ext2, and ext3) sharing the same API.  The history went a
> bit like this:

Yep, I know the history: I've been following this for a long time. :)

> - Andreas made attempt #1 to get a system call interface agreed on
> over a year ago now.  He incorporated several peoples suggestions,
> but eventually the discussion got sidetracked, died and nothing
> further happened;

Yep, and I brought up all these points last time, too.

> > But the ACL encoding is still hobbled: ...
> 
> I have been on the acl-devel mailing list for a long time now,
> and while these features all sound like good ideas or interesting
> projects, I have never seen anyone post a patch or request any
> specific changes to Andreas' ACL encoding in that time.

It was proposed over a year ago on fsdevel-list.  I've attached the
main proposal email, and I've posted the mailbox containing the
discussion at

	http://people.redhat.com/sct/ACL/ACL.mailbox.gz

Warning, it uncompresses to over 600k!

> It seems to me that the relatively simple implementation which
> Andreas has done is a good starting point (it has been used in
> production for a long time now).
> 
> His POSIX ACL encoding has a version field in it

Umm, and where in the EA man pages is this described?  How does an
application use the EA API?  That's what I'm concerned about.  

The EA API is fine, as far as it goes.  However, it doesn't talk _at
all_ about extending semantics.  It doesn't even say if it is legal to
use system EAs for POSIX ACLs.  Right now, system EAs are just a magic
way of stuffing undefined bits into undefined filesystems.  What if I
want to add non-user-modifiable EAs to a file for user-space reasons?
Eg. what if my backup tool wants to write a backup timestamp which the
user can't modify?  How do I do that?  The EA spec doesn't actually
say whether it is legal for applications to store their own data in
system EAs, and if so, which set of system EAs must be reserved for
system internal use.

> so if/when some
> people step forward to implement these features you've described,
> and if they require changes to the format, then there should be no
> reason they can't do it cleanly and in a filesystem-independent
> manner, right?

What format?  There _is_ no defined format.  There's some existing
practice, but no rules whatever right now.

Cheers,
 Stephen

--qMm9M+Fa2AknHoGS
Content-Type: message/rfc822
Content-Disposition: inline

Return-Path: <sct@redhat.com>
Received: from devserv.devel.redhat.com
	by localhost with IMAP (fetchmail-5.3.1)
	for sct@localhost (single-drop); Tue, 24 Oct 2000 12:41:49 +0100 (BST)
Received: from lacrosse.corp.redhat.com ([207.175.42.154])
	by devserv.devel.redhat.com (8.11.0/8.11.0) with ESMTP id e9OBO9d03523;
	Tue, 24 Oct 2000 07:24:09 -0400
Received: from dukat.scot.redhat.com ([10.0.1.44])
	by lacrosse.corp.redhat.com (8.9.3/8.9.3) with ESMTP id HAA13940;
	Tue, 24 Oct 2000 07:24:05 -0400
Received: (from sct@localhost)
	by dukat.scot.redhat.com (8.9.3/8.9.3) id MAA06060;
	Tue, 24 Oct 2000 12:21:05 +0100
Date: Tue, 24 Oct 2000 12:21:04 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andreas Gruenbacher <ag@bestbits.at>
Cc: linux-fsdevel@vger.kernel.org, openxdsm-devel@sourceforge.net,
   Stephen Tweedie <sct@redhat.com>, "Theodore Ts'o" <tytso@mit.edu>,
   Hans Reiser <reiser@ricochet.net>, Daniel Phillips <phillips@innominate.de>,
   Andreas Dilger <adilger@home.com>, Ben LaHaise <bcrl@redhat.com>
Subject: Re: [PROPOSAL] Extended attributes for Posix security extensions
Message-ID: <20001024122104.A5968@redhat.com>
In-Reply-To: <Pine.LNX.4.21.0010221620100.22349-100000@moses.parsec.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.21.0010221620100.22349-100000@moses.parsec.at>; from ag@bestbits.at on Sun, Oct 22, 2000 at 04:23:53PM +0200

Hi,

On Sun, Oct 22, 2000 at 04:23:53PM +0200, Andreas Gruenbacher wrote:
> 
> This is a proposal to add extended attributes to the Linux kernel.
> Extended attributes are name/value pairs associated with inodes.

What timing --- we had a long discussion (actually, several!) about
this very topic at the Miami storage workshop last week.

One of the main goals we had in getting people together to talk about
extended attributes in general, and ACLs in particular, was to deal
with the API issues cleanly.  In particular, we really want the API to
be at the same time:

   * General enough to deal with all of the existing,
     mutually-incompatible semantics for ACLs and attributes; and

   * Specific enough to define the requested semantics unambiguously
     for any one given implementation of the underlying attributes.

These points are really important.  We have people wanting to add ACL
support to ext2 in a manner which Samba can use --- can we do POSIX
ACLs with NT SID identifiers rather than with unix user ids?  If we
mount an NTFS filesystem, it will have native ACLs on disk.  How does
the API speficy that we want NT semantics, not POSIX semantics, for a
given request?

There is also the naming issue.  There are multiple independent
namespaces.  For extended attributes, there may be totally separate
namespaces for user attributes and for system ones, or there may be a
common namespace with per-attribute system status.  Again, these
different sets of semantics _already exist_ on filesystems which Linux
can mount (eg. NTFS, JFS and XFS), so the API has to deal with them.

There is already a kernel API which has this flexibility: the BSD
socket API handles these issues through the concepts of protocol
families and address families.  Those same two concepts are perfectly
matched to the extended attributes problem.


The proposal defines two "families" of attribute entities: attribute
families and name families.

An attribute family might be ATR_USER or ATR_SYSTEM to specify that we
are dealing with arbitrary user or system named extended attributes,
or ATR_POSIXACL to specify POSIX-semantics ACLs.  Obviously, this can
be extended to other ACL semantics without revving the API --- a new
attribute family would be all that is needed.

The "name family" is the other part of the equation.  Attributes in
the ATR_USER or ATR_SYSTEM families might be named with counted
strings, so they would have names in the ANAME_STRING name family.
POSIX ACLs, however, have a different namespace: ANAME_UID or
ANAME_GID.  The API cleanly deals with the difference between user and
group ACLs.  It also makes it easy to add support later on for more
complex operations: if we want to add NT SID support to ext2 ACLs so
that Samba and local accesses get the same access control, we can pass
ANAME_NTSID names to the ATR_POSIXACL attribute family without
changing the API.

Obviously the combinations of name types supported for any given
attribute family will depend on the underlying implementation, but
that's the whole point --- the API is expressive enough to define
unambiguously what the application is trying to do, so that if the
underlying filesystem doesn't support (say) POSIX ACLs, we get an
error back telling us so rather than attempting to do an incomplete
map of the POSIX request onto whatever the underlying filesystem
happens to support.


Before we look at the syscall API in detail, there's one other point
to note.  It is common to want to read or set one individual attribute
in isolation (even if it is an atomic set-and-get which is being
performed on that attribute).  Sometimes, however, you want to access
the entire set of related attributes as an ordered list.  ACLs are the
obvious case: if you have underlying semantics which allow you to mix
both PASS and DENY ACLs on a file, then the order of the ACLs
obviously matters.  

In such cases, you may sometimes want just to query or set the ACL for
a specific user, but often you will want to do something more complex
such as change the order of ACLs on the list or replace the entire
list as a single entity --- and you want to do so atomically.  So, the
simple "SET" and "GET" operations on named attributes (which
correspond to writing and reading the ACLs for specific named users in
the ATR_POSIXACL family) need to be augmented with SET variants which
append or prepend to the ACL list, or which atomically replace the old
ACL list in its entirety.


Our proposed kernel API looks something like this:

	sys_setattr (char *filename, int attrib_family, int op, 
		     struct attrib *old_attribs, int *old_lenp,
		     struct attrib *new_attribs, int new_len);

	sys_fsetattr(int fd, int attrib_family, int op, 
		     struct attrib *old_attribs, int *old_lenp,
		     struct attrib *new_attribs, int new_len);

where <op> can be

	ATR_SET		overwrite existing attribute
	ATR_GET		read existing attribute
	ATR_GETALL	read entire ordered attribute list (ignores new val)
	ATR_PREPEND	add new attribute to start of ordered list
	ATR_APPEND	add new attribute to end of ordered list
	ATR_REPLACE	replace entire ordered attribute list

and where <attribs> is a buffer of length <len> bytes of variable
length struct attrib records:

struct attrib {
	int	rec_len;		/* Length of the whole record:
					   should be padded to long
					   alignment */
	int	name_family;		/* Which namespace is the name in? */
	int	name_len;
	int	val_len;
	char	name[variable];		/* byte-aligned */
	char	val[variable];		/* byte-aligned */
};

ATR_SET will overwrite an existing attribute, or if the attribute does
not already exist, will append the new attribute (ie. it does not
override existing ACL controls, in keeping with the Principle of Least
Surprise).  If multiple instances of the name already exist, then the
first one is replaced and subsequent ones deleted.  If supplied with
an "old" buffer, all old attributes of that name will be returned.

For the PREPEND/APPEND/REPLACE operations, the entire old attribute
set is returned.

For GET, the <new> specification is read and all attributes which
match any items in <new> are returned, in the order in which they are
specified in <new>.  The actual value in <new> is ignored; only the
name is used.

For GETALL, <new> is ignored entirely.

*old_lenp should contain the size of the old attributes buffer on
entry.  It will contain the number of valid bytes in the old buffer on
exit.  If the buffer is not sufficiently large to contain all of the
attributes, E2BIG is returned.


This is just a first stab at documenting what feels like an
appropriate API.  It should be extensible enough for the future, but
is pretty easy to code to already --- existing filesystems don't have
to deal with any complexity they don't want to. 

Additionally, the use of well-defined namespaces for attributes means
that in the future we can implement things like common code for
generic attribute caching, or process authentication groups for
non-Unix-ID authentication tokens, without having to duplicate all of
that work in each individual filesystem.


The extended attribute patch currently on the acl-devel group simply
doesn't give us the ability to do extended attributes on any
filesystem other than ext2, because it has such specific semantics.
I'd rather avoid that, and I'd rather do so without adding a profusion
of different ACL and attribute syscalls in the process.

Cheers,
 Stephen

--qMm9M+Fa2AknHoGS--
