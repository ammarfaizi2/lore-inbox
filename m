Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264762AbTFLGoa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 02:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264763AbTFLGo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 02:44:29 -0400
Received: from [62.67.222.139] ([62.67.222.139]:28817 "EHLO kermit")
	by vger.kernel.org with ESMTP id S264762AbTFLGoT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 02:44:19 -0400
Date: Thu, 12 Jun 2003 08:57:49 +0200
From: Konstantin Kletschke <konsti@ludenkalle.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.70-mm7
Message-ID: <20030612065749.GB12651@sexmachine.doom>
Reply-To: Konstantin Kletschke <konsti@ludenkalle.de>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>
References: <1055286765.2371.4.camel@mars.goatskin.org> <1055288033.27439.4.camel@chtephan.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1055288033.27439.4.camel@chtephan.cs.pocnet.net>
Organization: Kletschke & Uhlig GbR
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Christophe Saout <christophe@saout.de> [Wed, Jun 11, 2003 at
* 01:33:53AM +0200]:                                                                 
>                                                                                                                                                 
> Ok, I think I found the problem.                                                                                                                
>                                                                                                                                                 
> In dm-ioctl.c in the function create this got changed:                                                                                          
>                                                                                                                                                 
> -       int minor;                                                                                                                              
> +       unsigned int minor = 0;                                                                                                                 
                                                                                                                                                  
...                                                                                                                                               
                                                                                                                                                  
> +       r = (minor < 0) ? next_free_minor(&minor) :                                                                                             
> specific_minor(minor);                                                                                                                          
> +       if (r < 0) {                                                                                                                            
>                                                                                                                                                 
                                                                                                                                                  
If I am seeing this right this changes were introduced in -mm8 (i.e. I                                                                            
wanted to change the code and I saw the changes have already been done).                                                                          
                                                                                                                                                  
In spite of that, when I boot -mm8 the device-mapper is very angry :)                                                                             
                                                                                                                                                  
device-mapper ioctl cmd 2 failed:                                                                                                                 
        No such device or address                                                                                                                 
Couldn't load device                                                                                                                              
        'GinaWild-l_swp0'.                                                                                                                        
                                                                                                                                                  
This is hopefully written down from screen correct so that the error                                                                              
should be clear...                                                                                                                                
                                                                                                                                                  
Konsti                                                                                                                                            

PS.:
Sorry Christophe, first attempt went out directly to your e-mail adress,
sometimes mutt drives me mad :-/

--                                                                                                                                                
2.5.70-mm4
Konstantin Kletschke <konsti@ludenkalle.de>, <konsti@ku-gbr.de>
GPG KeyID EF62FCEF
Fingerprint: 13C9 B16B 9844 EC15 CC2E  A080 1E69 3FDA EF62 FCEF
keulator.homelinux.org up 24 min, 1
