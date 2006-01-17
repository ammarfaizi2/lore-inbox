Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932381AbWAQMKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbWAQMKT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 07:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbWAQMKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 07:10:18 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:4910 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932381AbWAQMKR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 07:10:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=H1T6zacSp9UCvSb8yOczbvvuZchDOJNfdlQrWiaSJOu5IkBqKGaqIJPTCTf/fyF5ejyP3Os2q1+34CV0SDipVXvmf8gQVURklFFKcX+KuMuBq2hLqH2Qd5bsKcqoWSjs1Uu92zarjQ5R/zp12Zjzcwn+QMbfVNZkyIDzpfavZbQ=
Message-ID: <f69849430601170410q67fd075cka5fbff213b7f08d9@mail.gmail.com>
Date: Tue, 17 Jan 2006 04:10:15 -0800
From: kernel coder <lhrkernelcoder@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Observation on IDE read operation
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

I was analyzing the IDE i/o mechanism in linux kernel 2.4.32.I
observed following sequence of read requests to read a particular file
with size around 13kb.

1) block no=9706		 number of sectors=20

2) block no=9723		 number of sectors=4

3) block no=9725		 number of sectors=2

4) block no=9726		 number of sectors=2

As u can see 4 different requests were made to read blocks 9706 to
9715 , 9723 to 9724 , 9725 , 9726.

The function __make_request ensures that requests are rearranged and
merged so that consective blocks are read in one request.So please
tell me why separete requests were made for reading blocks 9723 to
9724 , 9725 , 9726 ,when requests from 9724 to 9726 can be merged into
one.

Is it suitable that instead of generating separte requests for reading
 9706 to 9715 and 9723 to 9726 blocks ,just one request for reading
9706 to 9726 blocks is issued.This will cause irrelevant blocks (9716
to 9722) to be read as well but they can be discarded.

 If all data blocks of that particular file are read in one
request,will it increase  the speed of read operation on that file.

shahzad
