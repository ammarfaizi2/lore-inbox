Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132583AbRDWXlo>; Mon, 23 Apr 2001 19:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132580AbRDWXld>; Mon, 23 Apr 2001 19:41:33 -0400
Received: from www.resilience.com ([209.245.157.1]:31365 "EHLO
	www.resilience.com") by vger.kernel.org with ESMTP
	id <S132576AbRDWXl2>; Mon, 23 Apr 2001 19:41:28 -0400
Mime-Version: 1.0
Message-Id: <p05100300b70a6c8bddc9@[209.245.157.6]>
In-Reply-To: <Pine.LNX.4.21.0104232301270.8859-100000@bits.bris.ac.uk>
In-Reply-To: <Pine.LNX.4.21.0104232301270.8859-100000@bits.bris.ac.uk>
Date: Mon, 23 Apr 2001 16:41:17 -0700
To: Matt <madmatt@bits.bris.ac.uk>, linux-kernel@vger.kernel.org
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: ioctl arg passing
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:09 PM +0100 4/23/01, Matt wrote:
>| struct instruction_t {
>|	__s16 code;
>|	__s16 rxlen;
>|	__s16 *rxbuf;
>|	__s16 txlen;
>|	__s16 *txbuf;
>| };
>
>So far, I now know I can grab stuff across the user <-> kernel divide as I
>planned. The only problem I'm left with, which was kindly pointed out to
>me, is a question of packing with respect to both kernel & user-space.
>
>Can anyone suggest a method of either assuring the above structure is
>always packed the same, or alterations so that the problem is
>minimised? Either splitting the one ioctl into many, etc.

struct instruction_t {
	__s16 code;
	__s16 rxlen;
	__s16 txlen;
	__s16 pad;
	__s16 *rxbuf;
	__s16 *txbuf;
};

This was it's always aligned and packed, regardless of compiler packing settings. This particular layout happens to work with 64-bit pointers as well.... (I'm assuming that __s16 is a signed 16-bit type).

You can move the pointers to the front, but it's not necessary in this case, so I tried to preserve some of your original ordering (code first, rx before tx).
-- 
/Jonathan Lundell.
