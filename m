Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283001AbRLIFAP>; Sun, 9 Dec 2001 00:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283002AbRLIFAG>; Sun, 9 Dec 2001 00:00:06 -0500
Received: from mailhost.nmt.edu ([129.138.4.52]:19726 "EHLO mailhost.nmt.edu")
	by vger.kernel.org with ESMTP id <S283001AbRLIE7x>;
	Sat, 8 Dec 2001 23:59:53 -0500
Subject: Re: File copy system call proposal
From: Quinn Harris <quinn@nmt.edu>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <9uuame$ssu$1@cesium.transmeta.com>
In-Reply-To: <1007782956.355.2.camel@quinn.rcn.nmt.edu>
	<9us387$poh$1@cesium.transmeta.com>
	<1007791439.355.7.camel@quinn.rcn.nmt.edu>
	<E16Chyk-0000zH-00@starship.berlin>  <9uuame$ssu$1@cesium.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 08 Dec 2001 21:56:25 -0700
Message-Id: <1007873785.354.0.camel@quinn.rcn.nmt.edu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2001-12-08 at 17:19, H. Peter Anvin wrote:
> 
> One thing that one could do for an in-kernel copy is to extend
> sendfile() to support any kind of file descriptor.  That'd be a very
> clean way to do it.
> 

I think the best thing would be to extend generic_file_write
(mm/filemap.c) to recognize if its writing a complete page to disk in
which case it will not duplicate that page.  (Issues with getting the
buffer cache to support this remain.)  This should make either the
mmap/write or sendfile aproach be zero-copy.  I am given the impression
that this is just what the TCP/IP version of write does to make it
zero-copy.

