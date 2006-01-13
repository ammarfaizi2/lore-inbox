Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964901AbWAMEC6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964901AbWAMEC6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 23:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964937AbWAMEC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 23:02:58 -0500
Received: from main.gmane.org ([80.91.229.2]:14823 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964901AbWAMEC5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 23:02:57 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: ide-cd turning off DMA when verifying DVD-R
Date: Fri, 13 Jan 2006 06:04:13 +0200
Message-ID: <pan.2006.01.13.04.04.13.412805@sci.fi>
References: <43C6CB99.50302@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cs181093116.pp.htv.fi
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jan 2006 22:35:21 +0100, Ondrej Zary wrote:

> Hello,
> I found this problem when burning DVDs using K3b (it uses growisofs to 
> do the work) with LG GSA-4167B drive:
> Burn process completes without any problems, then K3b ejects and reloads 
> the tray, then it calculates MD5 checksum from the image. Then it starts 
> reading the DVD back to calculate MD5 checksum of it. The moment it 
> starts to read, this appears in dmesg:
> 
> hdd: irq timeout: status=0xd0 { Busy }
> ide: failed opcode was: unknown
> hdd: DMA disabled
> hdd: ATAPI reset complete
> 
> And then it slowly reads the DVD in PIO mode. After about a hour, it 
> finishes with success. When I re-enable DMA mode ("hdparm -d1 /dev/hdd") 
> immediately after it was disabled, it works fine in - there are no more 
> errors in the log and the verification completes much sooner. I burnt 10 
> DVDs and it always does exactly this.
> 
> Any ideas why it does this? And why ide-cd disables the DMA?

I think the drive just takes too long to recongize the disc. My 4163B has
the same problem which is why I always close the tray manually or with
eject -t and wait a while before mounting or burning the disc. Of course
that won't help in your case. I guess the real fix would be to
increase some ide-cd timeout.

-- 
Ville Syrjälä
syrjala@sci.fi
http://www.sci.fi/~syrjala/


