Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286987AbSABMiY>; Wed, 2 Jan 2002 07:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286991AbSABMiM>; Wed, 2 Jan 2002 07:38:12 -0500
Received: from sun.fadata.bg ([80.72.64.67]:51473 "HELO fadata.bg")
	by vger.kernel.org with SMTP id <S286989AbSABMiF> convert rfc822-to-8bit;
	Wed, 2 Jan 2002 07:38:05 -0500
To: Aaron Lehmann <aaronl@vitelus.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] C undefined behavior fix
In-Reply-To: <87g05py8qq.fsf@fadata.bg> <20020102112821.GA13212@vitelus.com>
From: Momchil Velikov <velco@fadata.bg>
Date: 02 Jan 2002 13:40:06 +0200
In-Reply-To: <20020102112821.GA13212@vitelus.com>
Message-ID: <87u1u5yoa1.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Aaron" == Aaron Lehmann <aaronl@vitelus.com> writes:

Aaron> On Wed, Jan 02, 2002 at 01:03:25AM +0200, Momchil Velikov wrote:
>> Thus 
>> strcpy (dst, "abcdef" + 2)
>> gives
>> memcpy (dst, "abcdef" + 2, 5)

Aaron> IMHO gcc should not be touching these function calls, as they are not
Aaron> made to a standard C library, and thus have different behaviors. I'm
Aaron> suprised that gcc tries to optimize calls to these functions just
Aaron> based on their names.

IIRC, these identifiers are reserved by the C standard, thus the
compiler is right to assume that they have standard behavior. And note
that they DO have the standard behavior. It even doesn't matter if GCC
is right to judge by the names in each and every case, it is right
in _this_ case.

Aaron> The gcc manpage mentions

Aaron>        -ffreestanding
Aaron>            Assert that compilation takes place in a freestanding
Aaron>            environment.  This implies -fno-builtin.  A freestand­
Aaron>            ing environment is one in which the standard library
Aaron>            may not exist, and program startup may not necessarily
Aaron>            be at "main".  The most obvious example is an OS ker­
Aaron>            nel.  This is equivalent to -fno-hosted.

Aaron> Why is Linux not using this? It sounds very appropriate. The only

Because it results in less optimization. I see no point in
deliberately preventing the compiler from doing optimizations.

Regards,
-velco
