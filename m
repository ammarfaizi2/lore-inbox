Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261368AbUK0X6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbUK0X6K (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 18:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261370AbUK0X6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 18:58:10 -0500
Received: from neopsis.com ([213.239.204.14]:9890 "EHLO matterhorn.neopsis.com")
	by vger.kernel.org with ESMTP id S261368AbUK0X6H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 18:58:07 -0500
Message-ID: <41A9148E.6070501@dbservice.com>
Date: Sun, 28 Nov 2004 00:58:06 +0100
From: Tomas Carnecky <tom@dbservice.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcel Sebek <sebek64@post.cz>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document kfree and vfree NULL usage
References: <1101565560.9988.20.camel@localhost> <20041127171357.GA5381@penguin.localdomain>
In-Reply-To: <20041127171357.GA5381@penguin.localdomain>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Neopsis-MailScanner-Information: Please contact the ISP for more information
X-Neopsis-MailScanner: Found to be clean
X-MailScanner-From: tom@dbservice.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcel Sebek wrote:
> On Sat, Nov 27, 2004 at 04:26:00PM +0200, Pekka Enberg wrote:
> 
>>Hi,
>>
>>This patch adds comments for kfree() and vfree() stating that both accept
>>NULL pointers.  I audited vfree() callers and there seems to be lots of
>>confusion over this in the kernel.
>>
> I've cleaned up sound/ directory from "if (x) {k/v}free(x);" and similar
> constructions. I'm going to to this for most of the kernel if I found
> some time.

Isn't 'if (x) { free(x); }' faster than the call to free() with a NULL
pointer?
What about a macro ?
#define fast_free(x) if (x) { free(x); }
Or even
#define kfree(x) if (x) { _kfree(x); }
Or maybe a inline function so it doesn't break existing code.
inline void kfree(x) { if (x) { _kfree(x); } }

tom
