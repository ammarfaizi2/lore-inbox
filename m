Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262889AbTCKJyc>; Tue, 11 Mar 2003 04:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262888AbTCKJyc>; Tue, 11 Mar 2003 04:54:32 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:48900 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S262889AbTCKJya>; Tue, 11 Mar 2003 04:54:30 -0500
Message-ID: <3E6DB547.4060300@aitel.hist.no>
Date: Tue, 11 Mar 2003 11:07:03 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: Patrick E Kane <kane@urbana.css.mot.com>, linux-kernel@vger.kernel.org
Subject: Re: Stack growing and buffer overflows
References: <20030310230012.26391.qmail@linuxmail.org> <20030310172935.A1324@scapula.urbana.css.mot.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick E Kane wrote:

> I like the idea of turning off execute permission on the stack pages.

It has been shown before that this has these disadvantages:
1. More work settting up those access bits   (bloat & perf. degradation)
2. Some programs actually need an exec stack (loss of features)
3. It don't buy you _any_ security at all!   (didn't help anyway)

About (3): Of course it stops some of the current exploits, but there is
a trivial way to "enhance" stack-smashing exploits to work around the
non-exec stack:

You can still overwrite the function's return address, on that non-exec 
stack.  The cracker can no longer upload code and make the function 
return to that, but crackers don't need to!  All they need is to return 
to a place containing exec("/bin/sh") *and such places exist*, 
paritcularly in every program using libc.  So writing the the exploit
becomes a little harder, using it is as trivial as ever.

Spend the time fixing broken apps, or get them right from the start.  It 
is not as if writing safe C is _hard_.

Helge Hafting


