Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161540AbWAMKZb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161540AbWAMKZb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 05:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161545AbWAMKZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 05:25:31 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:51624 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1161540AbWAMKZa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 05:25:30 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Chris Wedgwood <cw@f00f.org>
Subject: Re: [PATCH 2 of 3] memcpy32 for x86_64
Date: Fri, 13 Jan 2006 12:24:36 +0200
User-Agent: KMail/1.8.2
Cc: "Bryan O'Sullivan" <bos@pathscale.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, hch@infradead.org, ak@suse.de,
       rdreier@cisco.com
References: <b4863171295fdb6e8206.1136922838@serpentine.internal.keyresearch.com> <1137081882.28011.1.camel@serpentine.pathscale.com> <20060113095625.GA3707@taniwha.stupidest.org>
In-Reply-To: <20060113095625.GA3707@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601131224.36545.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 January 2006 11:56, Chris Wedgwood wrote:
> On Thu, Jan 12, 2006 at 08:04:41AM -0800, Bryan O'Sullivan wrote:
> 
> > This is true for 64-bit writes over Hypertransport
> 
> is this something that will always be or just something current
> hardware does?

Yes, why risking that things will go wrong?
Also you'll get shorter code. Instead of

> +     .globl memcpy32
> +memcpy32:
> +     movl %edx,%ecx
> +     shrl $1,%ecx
> +     andl $1,%edx
> +     rep movsq
> +     movl %edx,%ecx
> +     rep movsd
> +     ret

you need just

	.globl memcpy32
memcpy32:
	movl %edx,%ecx
	rep movsd
	ret

With properly written inlined asms code will be
reduced to just "rep movsd".
--
vda
