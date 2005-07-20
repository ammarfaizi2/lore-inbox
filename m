Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261152AbVGTKpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVGTKpA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 06:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261153AbVGTKpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 06:45:00 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:11143 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261152AbVGTKo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 06:44:59 -0400
Message-ID: <42DE2A31.7080505@gmail.com>
Date: Wed, 20 Jul 2005 12:40:49 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, rth@twiddle.net,
       dhowells@redhat.com, kumar.gala@freescale.com, davem@davemloft.net,
       mhw@wittsend.com, Rogier Wolff <R.E.Wolff@bitwizard.nl>,
       nils@kernelconcepts.de, cjtsai@ali.com.tw, Lionel.Bouton@inet6.fr,
       benh@kernel.crashing.org, mchehab@brturbo.com.br, laredo@gnu.org,
       rbultje@ronald.bitfreak.net, middelin@polyware.nl, philb@gnu.org,
       tim@cyberelk.net, campbell@torque.net, andrea@suse.de,
       linux@advansys.com, mulix@mulix.org
Subject: Re: [PATCH] pci_find_device --> pci_get_device
References: <42DC4873.2080807@gmail.com> <200507191327.44415@bilbo.math.uni-mannheim.de> <42DD1FCF.4050304@gmail.com> <200507191820.35472@bilbo.math.uni-mannheim.de>
In-Reply-To: <200507191820.35472@bilbo.math.uni-mannheim.de>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rolf Eike Beer napsal(a):

>Your patch to arch/sparc64/kernel/ebus.c is broken, the removed and added 
>parts do not match in behaviour.
>  
>
I can't still see the difference.

if (pdev && (pdev->device == PCI_DEVICE_ID_SUN_RIO_EBUS))
    *is_rio_p = 1;
else
    *is_rio_p = 0;
AND
*is_rio_p = !!(pdev && (pdev->device == PCI_DEVICE_ID_SUN_RIO_EBUS));

aren't the same or these:

    while (pdev = pci_get_device(PCI_VENDOR_ID_SUN, PCI_ANY_ID, pdev))
        if (pdev->device == PCI_DEVICE_ID_SUN_EBUS ||
            pdev->device == PCI_DEVICE_ID_SUN_RIO_EBUS)
            break;
AND
  do {
        pdev = pci_find_device(PCI_VENDOR_ID_SUN, PCI_ANY_ID, pdev);
        if (pdev &&
            (pdev->device == PCI_DEVICE_ID_SUN_EBUS ||
             pdev->device == PCI_DEVICE_ID_SUN_RIO_EBUS))
            break;
    } while (pdev != NULL);

>If you add braces after if's please add the '{' in the same line as the if 
>itself. This will make the diff bigger, but then this matches 
>Documentation/Coding-style.
>  
>
Ok, this has been improved.

* Added for_each_pci_dev wherever it is appropriate.

New patch:
http://www.fi.muni.cz/~xslaby/lnx/lnx-pci_find-2.6.13-r3g4_2.patch
http://www.fi.muni.cz/~xslaby/lnx/lnx-pci_find-2.6.13-r3g4_2.patch.bz2

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10

