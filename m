Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268538AbTCAJel>; Sat, 1 Mar 2003 04:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268539AbTCAJel>; Sat, 1 Mar 2003 04:34:41 -0500
Received: from c17997.eburwd3.vic.optusnet.com.au ([210.49.198.98]:50429 "EHLO
	satisfactory.karma") by vger.kernel.org with ESMTP
	id <S268538AbTCAJel>; Sat, 1 Mar 2003 04:34:41 -0500
Date: Sat, 1 Mar 2003 20:44:55 +1100
From: Andrew Clausen <clausen@gnu.org>
To: "Randy.Dunlap" <randy.dunlap@verizon.net>
Cc: aia21@cantab.net, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: Re: [Linux-NTFS-Dev] [PATCH] reduce large stack usage
Message-ID: <20030301094454.GA1058@gnu.org>
References: <3E605BEF.89DB801F@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E605BEF.89DB801F@verizon.net>
User-Agent: Mutt/1.4i
X-Accept-Language: en,pt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Fri, Feb 28, 2003 at 11:06:23PM -0800, Randy.Dunlap wrote:
> This patch to 2.5.63 reduces stack usage in generate_default_upcase()
> from 0x3d4 bytes to just noise (on x86).
> 
> The arrays are static so they are still private (hidden), but
> now they aren't allocated on the stack and copied there for
> temp use.

BTW, you can declare "local" variables inside a function as static,
which makes them "global", but locally scoped.  The code should be
basically equivalent, but perhaps more elegant...

i.e.:

 uchar_t *generate_default_upcase(void)
 {
-	const int uc_run_table[][3] = { /* Start, End, Add */
+static const int uc_run_table[][3] = { /* Start, End, Add */
 	{0x0061, 0x007B,  -32}, {0x0451, 0x045D, -80}, {0x1F70, 0x1F72,  74},
 	{0x00E0, 0x00F7,  -32}, {0x045E, 0x0460, -80}, {0x1F72, 0x1F76,  86},
 	{0x00F8, 0x00FF,  -32}, {0x0561, 0x0587, -48}, {0x1F76, 0x1F78, 100},

Cheers,
Andrew

