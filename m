Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267740AbTBRJOL>; Tue, 18 Feb 2003 04:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267743AbTBRJOL>; Tue, 18 Feb 2003 04:14:11 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20747 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267740AbTBRJOK>;
	Tue, 18 Feb 2003 04:14:10 -0500
Message-ID: <3E51FBA1.7020208@pobox.com>
Date: Tue, 18 Feb 2003 04:23:45 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Dominik Brodowski <linux@brodo.de>
CC: Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: stuff-up in pcmcia/cardbus stuff
References: <15953.37244.263505.214325@argo.ozlabs.ibm.com> <20030218081529.GA2334@brodo.de>
In-Reply-To: <20030218081529.GA2334@brodo.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Brodowski wrote:
> Indeed. socket->pcmcia_socket (old) == socket->cls_d.s_info[0] (new)

If this is true...

> @@ -230,14 +230,16 @@
>  static int cardbus_suspend (struct pci_dev *dev, u32 state)
>  {
>  	pci_socket_t *socket = pci_get_drvdata(dev);
> -	pcmcia_suspend_socket (socket->pcmcia_socket);
> +	if (socket && socket->cls_d.s_info[0])
> +		pcmcia_suspend_socket (socket->cls_d.s_info[0]);
>  	return 0;
>  }
>  
>  static int cardbus_resume (struct pci_dev *dev)
>  {
>  	pci_socket_t *socket = pci_get_drvdata(dev);
> -	pcmcia_resume_socket (socket->pcmcia_socket);
> +	if (socket && socket->cls_d.s_info[0])
> +		pcmcia_resume_socket (socket->cls_d.s_info[0]);
>  	return 0;
>  }


1) ...why do you bother checking for NULL?  Isn't NULL indicative of a 
BUG(), instead?

2) why are multiple s_info records allocated, when you hardcode use of 
record #0 ?

	Jeff



