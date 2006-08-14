Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932352AbWHNQ76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbWHNQ76 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 12:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932381AbWHNQ75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 12:59:57 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:14545 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932438AbWHNQ7v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 12:59:51 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Organization: IBM Deutschland Entwicklung GmbH
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/6] ehea: interface to network stack
Date: Mon, 14 Aug 2006 18:59:47 +0200
User-Agent: KMail/1.9.1
Cc: Jan-Bernd Themann <ossthema@de.ibm.com>, Anton Blanchard <anton@samba.org>,
       Thomas Klein <tklein@de.ibm.com>, netdev <netdev@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Christoph Raisch <raisch@de.ibm.com>, Marcus Eder <meder@de.ibm.com>,
       =?iso-8859-1?q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
References: <44D99EFC.3000105@de.ibm.com> <20060814143842.GM479@krispykreme> <44E09A19.9050205@de.ibm.com>
In-Reply-To: <44E09A19.9050205@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608141859.48868.arnd.bergmann@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 August 2006 17:43, Jan-Bernd Themann wrote:
> as our queue size is always a power of 2, we simply use:
> i++;
> i &= (ringbufferlength - 1)
> 
> So we can get along without the if.
> 

The recommended (by Linus) way for dealing with ring buffers
like that is to always read the counter through an accessor
and don't care about the overflow when updating it.

You can write small access functions for that:

struct my_struct {
	...
	unsigned rbuf_index;
	unsigned rbuf_mask;
	...
};

static inline unsigned int my_index(struct my_struct *p)
{
	return p->rb_index & p->rb_mask;
}

static inline unsigned int my_index_next(struct my_struct *p)
{
	return (++p->rb_index) & p->rb_mask;
}

	Arnd <><
