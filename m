Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751532AbWCSRsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532AbWCSRsK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 12:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751538AbWCSRsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 12:48:10 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:2004 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751530AbWCSRsI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 12:48:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=j1NsxVicecOyxyPvISLaV4XcQHMtKj/qqlS/QqyxH7e38yXlQt9JHs0gy1PpHs7en17hbQpv/NTHw/8RP6mV7TKjjupxspQjwJYKuGcGuqAuBLz6ctFJ5hnAR0VX7tI9KoQOCQ12lqWS2tCc2wGpb1kvw/dIdFa8kGwwrQGpkcI=
Message-ID: <4ae3c140603190948s4fcd135er370a15003a0143a8@mail.gmail.com>
Date: Sun, 19 Mar 2006 12:48:07 -0500
From: "Xin Zhao" <uszhaoxin@gmail.com>
To: mikado4vn@gmail.com
Subject: Re: Question regarding to store file system metadata in database
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
In-Reply-To: <441CE71E.5090503@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4ae3c140603182048k55d06d87ufc0b9f0548574090@mail.gmail.com>
	 <441CE71E.5090503@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

well, the database could reside on another file system. So the
database based file system could be a secondary file system but
provide more features and  better performance. I am not saying that
database-based file system must be the only filesystem on the system.

On 3/19/06, Mikado <mikado4vn@gmail.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Where is that database located, on other filesystem or on database-based
> filesystem?
>
> Xin Zhao wrote:
> > I was wondering why only few file system uses database to store file
> > system metadata. Here, metadata primarily refers to directory entries.
> > For example, one can setup a database to store file pathname, its
> > inode number, and some extended attribution. File pathname can be used
> > as primary key. As such, we can achieve pathname to inode mapping as
> > well as many other features such as fast search and extended file
> > attribute management. In contrast, storing file system entries in
> > directory files may result in slow dentry search. I guess that's why
> > ReiserFS and some other file systems proposed to use B+ tree like
> > strucutre to manage file entries. But why not simple use database to
> > provide the same feature? DB has been heavily optimized to provide
> > fast search and should be good at managing metadata.
> >
> >  I guess one concern about this idea is  performance impact caused by
> > database system. I ran a test on a mysql database: I inserted about
> > 1.2 million such kind of records into an initially empty mysql
> > database. Average insertion rate is about 300 entries per second,
> > which is fast enough to handle normal file system burden, I think.  I
> > haven't try the query speed, but I believe it should be fast enough
> > too (maybe I am wrong, if so, please point that out.).
> >
> > Then I am a little curious why only few people use database to store
> > file system metadata, although I know WinFS plans to use database to
> > manage metadata. I guess one reason is that it is difficult for kernel
> > based file system driver to access database. But this could be
> > addressed by using efficient kernel/user communication mechanism.
> > Another reason could be the worry about database system. If database
> > system crashes, file system will stop functioning too. However, the
> > feature needed by file system is really a small part of database
> > system, A reduced database system should be sufficient to provide this
> > feature and be stable enough to support a file system.
> >
> > Can someone point out more issues that could become obstables to using
> > database to manage metadata for a file system?
> >
> > Many thanks!
> > Xin
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.2.1 (GNU/Linux)
> Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org
>
> iD8DBQFEHOceNWc9T2Wr2JcRAsKKAJ9t1fRZ1xczAaeruDUqTNeLMcGuiwCfeTNt
> 31pFUK79Q7BE1AptbmNqr9Q=
> =LbiF
> -----END PGP SIGNATURE-----
>
