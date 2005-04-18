Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbVDRMkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbVDRMkN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 08:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262059AbVDRMkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 08:40:12 -0400
Received: from Smtp2.univ-nantes.fr ([193.52.82.19]:55230 "EHLO
	smtp2.univ-nantes.fr") by vger.kernel.org with ESMTP
	id S262065AbVDRMj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 08:39:58 -0400
Message-ID: <4263AA9D.3000505@univ-nantes.fr>
Date: Mon, 18 Apr 2005 14:39:57 +0200
From: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Organization: CRIUN
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: E1000 - page allocation failure - saga continues :(
References: <20050414214828.GB9591@mail.muni.cz> <4263A3B7.6010702@univ-nantes.fr> <20050418122202.GE26030@mail.muni.cz> <4263A70F.5060409@univ-nantes.fr> <20050418123457.GF26030@mail.muni.cz>
In-Reply-To: <20050418123457.GF26030@mail.muni.cz>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas Hejtmanek a écrit :

>On Mon, Apr 18, 2005 at 02:24:47PM +0200, Yann Dupont wrote:
>  
>
>>>I know that kernel 2.6.6-bk4 works. So were there some memory manager changes
>>>since 2.6.6? If so it looks like there are some bugs. 
>>>On the other hand, ethernet driver should not allocate much memory but rather
>>>drop packets.
>>>
>>>Btw, are you using some TCP tweaks? E.g. I have default TCP window size 1MB.
>>>
>>>      
>>>
>>No tweaking at all. No jumbo frames.
>>    
>>
>
>There were assumptions that it is XFS related. Are you using XFS on that box?
>
>I'm able to deterministically produce this error:
>on XFS partition store a file from network using multiple threads. If file size
>is bigger then total memory, then it fails after major part of memory is used
>for a file cache.
>
>  
>
Ah yes, this is the case.
XFS all over ...

The server is quite heavily stressed, we have a bunch of servers
rsyncing on a big SAN volume - formatted with XFS, that's right.
(and, if that matters, XFS in on top of a EVMS volume (on top of a LVM2
region)...)

-- 
Yann Dupont, Cri de l'université de Nantes
Tel: 02.51.12.53.91 - Fax: 02.51.12.58.60 - Yann.Dupont@univ-nantes.fr

