Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262260AbUBXOoc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 09:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262261AbUBXOoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 09:44:32 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:9205 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262260AbUBXOo0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 09:44:26 -0500
Subject: Re: JFS default behavior / UTF-8 filenames
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: kernel@mikebell.org
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040222192237.GC540@tinyvaio.nome.ca>
References: <1076886183.18571.14.camel@m222.net81-64-248.noos.fr>
	 <20040219105913.GE432@tinyvaio.nome.ca>
	 <1077199506.2275.12.camel@shaggy.austin.ibm.com>
	 <20040219234746.GG432@tinyvaio.nome.ca>
	 <1077289257.2533.23.camel@shaggy.austin.ibm.com>
	 <20040222192237.GC540@tinyvaio.nome.ca>
Content-Type: text/plain
Message-Id: <1077633850.2618.16.camel@shaggy.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 24 Feb 2004 08:44:10 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-02-22 at 13:22, kernel@mikebell.org wrote:

> 
> And that's why I was saying I think UTF-8 mode is the "least broken" for
> any filesystem that stores filenames in a specific encoding rather than
> "as the client submitted it". And most especially for UCS-2/UTF-16
> filesystems.

I receive a lot of complaints when JFS does not accept names because
they contain an "invalid" character.  Defaulting to UTF-8 will cause
some non-utf-8 filenames to be rejected.  The change I made makes the
default behavior sane and posix-compliant.  It won't make everybody
happy, but it will provide predicable, sane behavior.

> I think the default for a filesystem should be something that absolutely
> will not disappear your files. So for NTFS/JFS, it should be UTF-8. And
> if a traditional UNIX filesystem wants to do a UTF-8 only mode, I think
> ideally it should be done at mkfs time rather than mount time.

The biggest problem with changing the default now is that the behavior
was unpredictable before.  Now, the default behavior will not allow
filenames to be stored with UCS-2 characters greater than 0x00ff, so
there won't be inaccessible files unless the iocharset option has been
used.  This allows the average user to get sane behavior, but allows the
flexibility of accessing the file system in a specific character set for
those users who know what they are doing.
-- 
David Kleikamp
IBM Linux Technology Center

