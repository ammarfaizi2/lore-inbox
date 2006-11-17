Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755783AbWKQSS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755783AbWKQSS6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 13:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755780AbWKQSS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 13:18:58 -0500
Received: from mx.pathscale.com ([64.160.42.68]:9178 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1755514AbWKQSS5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 13:18:57 -0500
Message-ID: <455DFD23.8050504@pathscale.com>
Date: Fri, 17 Nov 2006 10:19:15 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Steve Wise <swise@opengridcomputing.com>
Cc: rdreier@cisco.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [openib-general] [PATCH  09/13] Core WQE/CQE Types
References: <20061116035826.22635.61230.stgit@dell3.ogc.int> <20061116035912.22635.21736.stgit@dell3.ogc.int>
In-Reply-To: <20061116035912.22635.21736.stgit@dell3.ogc.int>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Wise wrote:
> T3 WQE and CQE structures, defines, etc...

I notice that none of the fields in these structs seem to be 
endianness-annotated, but that there's a lot of cpu_to_be64 and so on 
being used to frob values into them.  Please make sure that the driver 
passes a sparse check, which it looks like it almost certainly cannot 
right now.

> +#define RING_DOORBELL(doorbell, QPID) { \
> +	(writel(((1<<31) | (QPID)), doorbell)); \
> +}

Should probably be an inline function instead of a macro.

	<b
