Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264333AbTCYXmn>; Tue, 25 Mar 2003 18:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264387AbTCYXmn>; Tue, 25 Mar 2003 18:42:43 -0500
Received: from cm19173.red.mundo-r.com ([213.60.19.173]:53317 "EHLO
	trasno.mitica") by vger.kernel.org with ESMTP id <S264333AbTCYXmm> convert rfc822-to-8bit;
	Tue, 25 Mar 2003 18:42:42 -0500
To: =?iso-8859-1?q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add checkstack Makefile target
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <20030325134908.GA30822@wohnheim.fh-wedel.de>
 =?iso-8859-1?q?(J=F6rn?= Engel's message of "Tue, 25 Mar 2003 14:49:08
 +0100")
References: <20030303211647.GA25205@wohnheim.fh-wedel.de>
	<20030304070304.GP4579@actcom.co.il>
	<20030304072443.GA5503@wohnheim.fh-wedel.de>
	<20030304102121.GC6583@wohnheim.fh-wedel.de>
	<20030304105739.GD6583@wohnheim.fh-wedel.de>
	<20030304190854.GA1917@mars.ravnborg.org>
	<20030305145149.GA7509@wohnheim.fh-wedel.de>
	<20030305191516.GB1841@mars.ravnborg.org>
	<20030305195451.GB10871@wohnheim.fh-wedel.de>
	<20030323190844.GA6699@mars.ravnborg.org>
	<20030325134908.GA30822@wohnheim.fh-wedel.de>
Date: Wed, 26 Mar 2003 00:53:42 +0100
Message-ID: <86isu7uho9.fsf@trasno.mitica>
User-Agent: Gnus/5.090015 (Oort Gnus v0.15) Emacs/21.2.93
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "jörn" == Jörn Engel <joern@wohnheim.fh-wedel.de> writes:

jörn> On Sun, 23 March 2003 20:08:45 +0100, Sam Ravnborg wrote:
>> 
>> checkstack needs a configured and build kernel, hence the
>> prerequisite vmlinux.
>> So it is located at the right spot and shall not be listed in
>> noconfig_targets.
>> 
>> Only tiny issue is that you miss:
>> .PHONY: checkstack

jörn> True. Ok, hopefully this is the last missing bit. Can I bother Linus
jörn> with it?

Once there, please just add:
	} elsif ($arch =~ /^mips64$/) {
		#8800402c:       67bdfff0        daddiu  sp,sp,-16
		$re = qr/.*(daddiu.*sp,sp,-(([0-9]{2}|[3-9])[0-9]{2}))/o;
	} elsif ($arch =~ /^mips$/) {
		#88003254:       27bdffe0        addiu   sp,sp,-32
		$re = qr/.*(addiu.*sp,sp,-(([0-9]{2}|[3-9])[0-9]{2}))/o;

and it should also works on mips/mips64.

I think that the lines should also work for mipsel and mipsel64, but
don't have a crosscompiler handy.

Thanks, Juan.



-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
