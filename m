Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313681AbSDJTxP>; Wed, 10 Apr 2002 15:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313687AbSDJTxO>; Wed, 10 Apr 2002 15:53:14 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:47120 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S313681AbSDJTxN>; Wed, 10 Apr 2002 15:53:13 -0400
Message-ID: <3CB49819.140EEC01@linux-m68k.org>
Date: Wed, 10 Apr 2002 21:52:57 +0200
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: "Justin T. Gibbs" <gibbs@scsiguy.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.19-pre6 standardize {aic7xxx,aicasm}/Makefile
In-Reply-To: <2317.1018406503@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Keith Owens wrote:

>     foo_files := $(srcfile foo-gen) $(srcfile foo.out_shipped)
>     $(objfile foo_sum.d): $(srcfile foo_sum) $(foo_files)

Why don't we use a script like this:

set -e 
src=$1
dst=$2
shift 2

test -f $dst && tail -1 $dst | sed 's,/\* \(.*\) \*/,\1,' | md5sum -c &&
touch $dst && exit 0
echo "$@"
"$@"
echo "/* $(md5sum $src) */" >> $dst

Then just call it with:
	<script> <src> <dst> <build command>

This is much simpler and also it also gets rid of these small checksum
files.

bye, Roman
