Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262580AbUDTM2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262580AbUDTM2b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 08:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262772AbUDTM2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 08:28:31 -0400
Received: from main.gmane.org ([80.91.224.249]:62858 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262580AbUDTM22 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 08:28:28 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Subject: Re: RFC: executable archive
Date: Tue, 20 Apr 2004 14:28:24 +0200
Message-ID: <yw1xy8oq3kbb.fsf@kth.se>
References: <1082462304.27255.76.camel@pc-16.office.scali.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 213-187-164-3.dd.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:nLXmfaVzpGcvt0lOSKMqbSowzvk=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Terje Eggestad <terje.eggestad@scali.com> writes:

> Hello everybody
>
> I wanted to share and idea (and I'm sure I going to get booh'ed of the
> list but...) with you all. 
>
> One thing have annoyed me for a long time while writing perl progs, and
> that it not possible to "link" it, in that programs must span multiple
> files to be manageable as they grow. I'm sure we all agree that only
> trivial programs can be coded in a single source file. 
> The annoyment stems from the fact that a single "executable" must be
> distributed as multiple files. 
> A problem with perl, that Larry Wall should have though of right?
>
> Same problem with python (i'm just learning), and a collection of .class
> files for java. 
> The problem is compounded that all decent scripting languages allow
> compiled modules in the shaped of a shared object, which make it really
> hard on the developers of the scripting engine to make single exec. 
>
> What would solve it is have an executable archive, in where you put the
> top level script, subscripts, shared objects, and any other file it may
> need. 
>
> It would be nice to have a general solution to the problem. 
>
> My first though would be to make a stub, and put the ar file in the data
> area of the process, something akind to self extracting zip files on
> dos/windoze.
> A couple of problems: 
> a) you can't "mount" the ar file to make it visible to the process as a
> part of it's file system view. ( Atleast not without intercepting a
> whole lot of libc calls) 
> b) unpacking it somewhere would clobber up your fs as it would not be
> cleaned up after a program crash or machine crash. 
>
> Ideally I'd like to see the files in the ar as in the cwd, but that
> would make a namespace collision possible.   
>
> The second though would be to do it in the kernel, which would go
> something like this:
>
> - let the exec() handler in the kernel recognize the exec-ar, just like
> it recognizes the #! magic. 
> - use the loopback mount device to mount the ar (read only) under
> /proc/self/archive  
> (- it would be nice to do something to the env's like adding
> /proc/self/archive to PATH, LD:LIBRARY_PATH, of honor a file like
> /proc/self/env to modify the envs)
> - now exec the file /proc/self/archive/main

Apart from the /proc manipulations, all of the above could be
accomplished using binfmt_misc and a suitable wrapper program.

-- 
Måns Rullgård
mru@kth.se

