Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932102AbVKTWxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbVKTWxE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 17:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbVKTWxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 17:53:04 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:47539 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932102AbVKTWxD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 17:53:03 -0500
Date: Sun, 20 Nov 2005 22:52:56 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Markus Lidel <Markus.Lidel@shadowconnect.com>
Cc: "David S. Miller" <davem@davemloft.net>, alan@lxorguk.ukuu.org.uk,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] I2O: SPARC fixes
Message-ID: <20051120225256.GC27946@ftp.linux.org.uk>
References: <437E7ADB.5080200@shadowconnect.com> <20051118.172230.126076770.davem@davemloft.net> <1132371039.5238.14.camel@localhost.localdomain> <20051118.203707.129707514.davem@davemloft.net> <4380EDB1.1080308@shadowconnect.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4380EDB1.1080308@shadowconnect.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 20, 2005 at 10:42:09PM +0100, Markus Lidel wrote:
> Hi...
> Sounds good to me. Could i then find out if some BE<=>LE issues are still 
> left? If so, is there a document which describes how it is done, or at 
> least has a driver added it already?

Hmm...

struct i2o_message {
        union {
                struct {
                        u8 version_offset;
                        u8 flags;
                        u16 size;
                        u32 target_tid:12;
                        u32 init_tid:12;
                        u32 function:8;
                        u32 icntxt;     /* initiator context */
                        u32 tcntxt;     /* transaction context */
                } s;
                u32 head[4];
        } u;
        /* List follows */
        u32 body[0];
};

is one hell of an endianness issue right fscking there.
