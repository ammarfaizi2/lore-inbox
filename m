Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030904AbWKOTeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030904AbWKOTeU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 14:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030938AbWKOTeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 14:34:20 -0500
Received: from smtpout08-04.prod.mesa1.secureserver.net ([64.202.165.12]:39366
	"HELO smtpout08-04.prod.mesa1.secureserver.net") by vger.kernel.org
	with SMTP id S1030904AbWKOTeT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 14:34:19 -0500
Message-ID: <455B6BB1.7030009@seclark.us>
Date: Wed, 15 Nov 2006 14:34:09 -0500
From: Stephen Clark <Stephen.Clark@seclark.us>
Reply-To: Stephen.Clark@seclark.us
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22smp i686; en-US; m18) Gecko/20010110 Netscape6/6.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Arjan van de Ven <arjan@infradead.org>, Takashi Iwai <tiwai@suse.de>,
       David Miller <davem@davemloft.net>, jeff@garzik.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
References: <Pine.LNX.4.64.0611141846190.3349@woody.osdl.org>  <20061114.190036.30187059.davem@davemloft.net>  <Pine.LNX.4.64.0611141909370.3349@woody.osdl.org>  <20061114.192117.112621278.davem@davemloft.net>  <s5hbqn99f2v.wl%tiwai@suse.de>  <Pine.LNX.4.64.0611150814000.3349@woody.osdl.org> <1163607889.31358.132.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0611150829460.3349@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0611150829460.3349@woody.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>On Wed, 15 Nov 2006, Arjan van de Ven wrote:
>  
>
>>well we could cheat some. And have the generic code for this just
>>register the irq handler for both somehow.
>>    
>>
>
>Well, not generic code. It would have to be the driver itself that does 
>it, since generic code doesn't even know (at irq request time - and when 
>they are generated - it just gets the irq number).
>
>And the thing is, once you do that, all the advantages of MSI totally go 
>away - both the "nice" ones and the "really good ones" (the latter being 
>the hopeful eventual removal of irq routing confusions). So if you do 
>that, the better solution is for the driver to say "I won't use MSI at 
>all".
>
>Really.
>
>It all boils down to the same thing: either we have to know that MSI works 
>(where "know" is obviously relative - it's not like you can avoid _all_ 
>bugs, but dammit, even a single report of "not working" means that there 
>are probably a ton of machines like that, and we did something wrong), or 
>we shouldn't use it. There is no middle ground. You can't really safely 
>"test" for it, and while you _can_ say "just do both", it doesn't really 
>help anything (and potentially exposes you to just more bugs: if enablign 
>MSI actually _does_ disable INTx, but then doesn't work, at a minimum you 
>end up with a device that doesn't work, even if the rest of the kernel 
>might be ok).
>
>And btw, I say this as a person whose new main machine used to have HDA 
>routed over MSI, and the decision to default to it off meant that it went 
>back to the regular INTx thing.
>
>(Btw, MSI interrupts also seem to not participate in CPU balancing:
>
> 22:      41556      43005   IO-APIC-fasteoi   HDA Intel
>506:     110417          0   PCI-MSI-edge      eth0
>
>  
>
mine do:$ cat /proc/interrupts
           CPU0       CPU1
  0:    7986702    7971263   IO-APIC-edge      timer
...
 20:      90626      95073   IO-APIC-fasteoi   uhci_hcd:usb2
220:       1722       1415   PCI-MSI-edge      HDA Intel
NMI:          0          0
LOC:   15957069   15957071
ERR:          0
MIS:          0

Also, I find it disturbing that we are forcing users to have know about 
all these
magic options that have to be put on the kernel boot line. My hard drive 
on my
new laptop would only run at 1.2mbs until I found out I had to use 
combined_mode=libata
and build a new ramdisk that included ata_piix.

My $.02
Steve

>which is another semantic change introduced by using MSI)
>
>			Linus
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>


-- 

"They that give up essential liberty to obtain temporary safety, 
deserve neither liberty nor safety."  (Ben Franklin)

"The course of history shows that as a government grows, liberty 
decreases."  (Thomas Jefferson)



