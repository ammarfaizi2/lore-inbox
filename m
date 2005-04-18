Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261676AbVDRFVB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261676AbVDRFVB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 01:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbVDRFVB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 01:21:01 -0400
Received: from tama5.ecl.ntt.co.jp ([129.60.39.102]:13196 "EHLO
	tama5.ecl.ntt.co.jp") by vger.kernel.org with ESMTP id S261676AbVDRFUv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 01:20:51 -0400
Message-ID: <426343AA.4090602@lab.ntt.co.jp>
Date: Mon, 18 Apr 2005 14:20:42 +0900
From: Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Jacobowitz <dan@debian.org>
CC: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 & x86_64: Live Patching Funcion on 2.6.11.7
References: <4261DC62.1070300@lab.ntt.co.jp> <20050416234439.5464e188.davem@davemloft.net> <20050417185143.GA5002@nevyn.them.org> <20050417133252.353a5666.davem@davemloft.net> <42631043.7000409@lab.ntt.co.jp> <20050418044115.GA15002@nevyn.them.org>
In-Reply-To: <20050418044115.GA15002@nevyn.them.org>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Jacobowitz wrote:

>On Mon, Apr 18, 2005 at 10:41:23AM +0900, Takashi Ikebe wrote:
>  
>
>>Daniel-san,
>>GDB based approach seems not fit to our requirements. GDB(ptrace) based 
>>functions are basically need to be done when target process is stopping. 
>>From our experience, sometimes patches became to dozens to hundreds at 
>>one patching, and in this case GDB based approach cause target process's 
>>availability descent.
>>    
>>
>
>That's right, it does require the target process be stopped.  If it
>isn't stopped how do you know it isn't executing the same instruction
>you're currently patching?
>
>Even with hundreds of kilobytes of patch, I have trouble imagining this
>takes a substantial amount of time.
>  
>
Pannus patch does not require target process stop while loading(mapping)
patch module to target process memory,
but as you described, target process stopping is needed whenever check
EIP not to conflict, and overwrite jump assembly code.(This makes only
few milliseconds target process stopping. Even on hundreds, it only
takes dozens mill-seconds yet.)
Typically telecoms application needs soft real time, and has timeout.
This kind of framework can not stop target process so long(Should be
dozens milliseconds at worst).
We want not to stop target process whenever patch module is loading....
we want not to stop target process as possible as.

-- 
Takashi Ikebe
NTT Network Service Systems Laboratories
9-11, Midori-Cho 3-Chome Musashino-Shi,
Tokyo 180-8585 Japan
Tel : +81 422 59 4246, Fax : +81 422 60 4012
e-mail : ikebe.takashi@lab.ntt.co.jp


