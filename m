Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266293AbUHYXln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266293AbUHYXln (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 19:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266525AbUHYXlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 19:41:42 -0400
Received: from [195.23.16.24] ([195.23.16.24]:25531 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S266293AbUHYXkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 19:40:32 -0400
Message-ID: <412D236E.3030401@grupopie.com>
Date: Thu, 26 Aug 2004 00:40:30 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Matt Mackall <mpm@selenic.com>, linux-kernel@vger.kernel.org,
       bcasavan@sgi.com
Subject: Re: [PATCH] kallsyms data size reduction / lookup speedup
References: <1093406686.412c0fde79d4f@webmail.grupopie.com> <20040825173941.GJ5414@waste.org> <412CDE9D.3090609@grupopie.com> <20040825185854.GP31237@waste.org> <412CE3ED.5000803@grupopie.com> <20040825192922.GH21964@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040825192922.GH21964@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.27.0.6; VDF: 6.27.0.32; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Wed, Aug 25, 2004 at 08:09:33PM +0100, Paulo Marques wrote:
> 
>>Matt Mackall wrote:
>>
>>>...
>>>
>>>FYI, killing the seq_file stuff will likely prove unpopular. So you'll
>>>want to do that in a separate patch. If it doesn't affect the way
>>>you're handling compression, please repost your compression patch. I
>>>have a few comments, but otherwise I think we should move forward with it.
>>
>>I'm still not sure that the seq_file is the culprit, but doing
>>a 10000 symbol decompression in a user space application takes
>>about 340us, whereas doing a "time cat /proc/kallsyms > /dev/null"
>>gives approx. 0.2s! (this is all on a Pentium4 2.8GHz)
>>
>>*If* the seq_file is the culprit, then I don't think removing
>>it (or improving it) will be unpopular.
> 
> 
> If it really spends that much in seq_file, I bet anything that it got
> *very* dumb iterator.  Which should be fixable...

That is why I kept a big *If* in that sentence. I'm quite new to all
this, and I'm still reading a lot of source code.

If the culprit is in fact seq_file, and seq_file can be improved in a
way that works for everyone (not only kallsyms), then I also agree
that is is the way to go. But hunting this down might prove that the
problem is somewhere else. It is just too soon to draw conclusions.

-- 
Paulo Marques - www.grupopie.com
