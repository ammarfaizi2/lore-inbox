Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbTHYWhN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 18:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262391AbTHYWhN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 18:37:13 -0400
Received: from codepoet.org ([166.70.99.138]:6305 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S262382AbTHYWhL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 18:37:11 -0400
Date: Mon, 25 Aug 2003 16:37:12 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OT] sizeof C types ...
Message-ID: <20030825223711.GA7809@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>,
	linux-kernel@vger.kernel.org
References: <20030825191339.GA28525@www.13thfloor.at> <20030825202721.A10828@infradead.org> <20030825193837.GB28525@www.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030825193837.GB28525@www.13thfloor.at>
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Aug 25, 2003 at 09:38:37PM +0200, Herbert Pötzl wrote:
> thanks, almost figured that, but I'm looking for
> a tabular info where the different architectures
> are present like the folowing:
> 
> 	      i386 | ia64 | alpha | sparc | wossname ...
> -----------+-------+------+-------+-------+-------------------
> char	   |     8 |      |       |       |
> short      |    16 |      |       |       |
> int        |    32 |      |       |       |
> long       |    32 |      |       |       |
> long long  |    64 |      |       |       |

If one cares about the exact number of bits, IMHO one should be
using stdint.h, as defined by ISO-IEC-9899-1999 (C99), section
7.18 Integer types.  

Using type such as int8_t, int16_t, int32_t, int64_t, and
uint8_t, uint16_t, uint32_t, uint64_t are the One True Way of
reliably, portably, getting the number of bits you want.  It
would be very nice if the kernel were converted to use these
types as well.  It would also be nice if every architecture
properly supported C99.  Unfortunately, that is not true on
either count.  For example, if you want your code to interoperate
with windoz, you will want to do something such as....

#if defined(_WIN32) || defined(__WIN32__)
# define uint8_t  unsigned __int8
# define uint16_t unsigned __int16
# define uint32_t unsigned __int32
# define uint64_t unsigned __int64
# define int8_t  __int8
# define int16_t __int16
# define int32_t __int32
# define int64_t __int64
#else
# include <stdint.h>
#endif

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
