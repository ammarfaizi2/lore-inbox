Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262766AbUKZWzc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262766AbUKZWzc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 17:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263407AbUKZWw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 17:52:59 -0500
Received: from [83.151.192.5] ([83.151.192.5]:42163 "HELO smtp.e7even.com")
	by vger.kernel.org with SMTP id S262831AbUKZWtF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 17:49:05 -0500
Subject: Re: file as a directory
From: Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>
To: Christian Mayrhuber <christian.mayrhuber@gmx.net>
Cc: reiserfs-list@namesys.com, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200411241711.28393.christian.mayrhuber@gmx.net>
References: <2c59f00304112205546349e88e@mail.gmail.com>
	 <1101287762.1267.41.camel@pear.st-and.ac.uk>
	 <4d8e3fd304112407023ff0a33d@mail.gmail.com>
	 <200411241711.28393.christian.mayrhuber@gmx.net>
Content-Type: text/plain
Message-Id: <1101379820.2838.15.camel@grape.st-and.ac.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 25 Nov 2004 10:50:21 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-11-24 at 16:11, Christian Mayrhuber wrote:
> On Wednesday 24 November 2004 16:02, Paolo Ciarrocchi wrote:
> > On 24 Nov 2004 09:16:03 +0000, Peter Foldiak
> > <peter.foldiak@st-andrews.ac.uk> wrote:
> > [...] 
> > > I would really like to implement this for the next version of Hans' file
> > > system.
> > 
> > I don't undersand how you want to use Xpath for not XML file.
> > I agree with you that the idea behind Xpath is cool but I fail to
> > unserstand how it can be applied to anything but XML
> > Paolo
> 
> Apache Cocoon uses so called generators to parse non-XML formats and produce a 
> XML representation thereof. This XML can be addressed by XPath.
> To store modifications back this XML needs to be serialized to the original
> format. That's **very** fat and slow.
> 
> Maybe an automount with a special fuse filesystem could accomplish this.
> 
> For example:
> # cd /etc/passwd/..metas/contents/
> 
> automounts /etc/passwd as "fuse-xpath-passwd" fs 
> to /etc/passwd/..metas/contents/
> 
> Doing 'cat /etc/passwd/..metas/contents/shell[username = "joe"]' could work 
> then.
> 
> Reiser4 would need a content-mount plugin that automounts
> the respective file by means of a per file configureable
> mount command. Something like
> # cat /etc/passwd/..metas/plugins/content-mount
> -t fuse-xpath-passwd -o ro
> 
> fuse-xpath-* filesystems would have to be written. These could be designed 
> similiar to the apache cocoon approach of generators/serializers to
> work with an intermediate XML representation of the file interior.
> 
> All the stuff besides mounting the fuse-xpath-fs's would happen in userspace.
> I don't think that anyone can guarantee posix fs semantics by this approach.

The problem with the
cat /etc/passwd/..metas/contents/shell[username = "joe"]
syntax is that it doesn't really achieve namespace unification.
As far as I understand the benefits of a unified namespace are due to
the user and the applications not having to know the details of what
they are dealing with. So, for instance, the nice thing about the
unification of files and devices in Unix is that an application (most
often) can treat a device in the same way as a file (or a pipe, etc.).
This is what gives it real flexibility.
The above syntax assumes you know exactly where the file "ends", and
where the parts of the file "begins" (indicated by the ..metas in your
path). Couldn't we get rid of ..metas from the path?

Also, what I am suggesting is not just to be able to select inside XML
files but also to extend XPath-like selection ABOVE the file level too,
to be used as if the whole file system was like a single big virtual XML
file.
 Peter

