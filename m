Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267199AbSKMNQz>; Wed, 13 Nov 2002 08:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267216AbSKMNQz>; Wed, 13 Nov 2002 08:16:55 -0500
Received: from modemcable217.53-202-24.mtl.mc.videotron.ca ([24.202.53.217]:23830
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267215AbSKMNQy>; Wed, 13 Nov 2002 08:16:54 -0500
Date: Wed, 13 Nov 2002 08:17:54 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH][2.5] Remove BUG in cpu_up 
In-Reply-To: <20021113093843.5C5142C253@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0211130804380.24523-100000@montezuma.mastecende.com>
X-Operating-System: Linux 2.4.19-pre5-ac3-zm4
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Nov 2002, Rusty Russell wrote:

> Err, no.  If __cpu_up(cpu) succeeded, that means the cpu should bloody
> well be online!

smp startup looks rather convoluted to me right now, but if i see it 
correctly, __cpu_up should eventually be doing a wakeup_secondary_via_INIT 
on vanilla i386 correct? In that case, the processor accepting the IPI 
doesn't necessarily mean it will have managed to initialise (if at all) itself by 
the time you do that cpu_online check, the wakeup_secondary_via_INIT will 
simply tell you wether you succeeded in sending the IPI. There are i386 
systems which take considerably long to do that AP initialisation 
procedure. I still reckon the most you should do there is specify 
PENDING with the cpu in question sending an ONLINE notification when it 
finally does all init.

	Zwane

-- 
function.linuxpower.ca

