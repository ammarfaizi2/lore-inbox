Return-Path: <owner-linux-pci@atrey.karlin.mff.cuni.cz>
X-OfflineIMAP-x422171562-6772656752656d6f7465-6c696e75782d706369: 1148566864-0688365502996-v4.0.11
thread-index: AcZ/5lUvtwIDR8l/R126lVGxNoJK1A==
Delivery-Date: Thu, 25 May 2006 12:19:20 +0200
Message-ID: <000201c67fe6$552f32c0$0b64a8c0@mehnertedv.local>
Date: Thu, 25 May 2006 12:31:07 +0200
From: "Jiri Slaby" <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
Cc: "Jeff Garzik" <jeff@garzik.org>, "Greg KH" <gregkh@suse.de>,
	"Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
	<linux-pci@atrey.karlin.mff.cuni.cz>,
	"Ralf Baechle" <ralf@linux-mips.org>
X-Mailer: Microsoft CDO for Exchange 2000
Subject: Re: [PATCH 3/3] pci: gt96100eth use pci probing
References: <20060525003151.598EAC7C19@atrey.karlin.mff.cuni.cz> <4474FFE1.4030202@garzik.org> <44758308.2040408@gmail.com>
In-Reply-To: <44758308.2040408@gmail.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: <"unlisted-recipients:"@atrey.karlin.mff.cuni.cz>,
	<"no To-headeroninput"@atrey.karlin.mff.cuni.cz>,
	"IMB Recipient 1" <mspop3connector.stefan@mehnert-edv.de>
Content-Class: urn:content-classes:message
Importance: normal
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 25 May 2006 10:31:07.0687 (UTC) FILETIME=[554BBB70:01C67FE6]
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:5df3490ebbf8888d64f9643250eb1e65
Sender: owner-linux-pci@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-pci@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-pci@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-pci-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>

Jiri Slaby napsal(a):
> Jeff Garzik napsal(a):
>> Jiri Slaby wrote:
>>> +static int __init gt96100_probe1(struct pci_dev *pdev, int port_num)
>>>  {
>>>      struct gt96100_private *gp = NULL;
>>> -    struct gt96100_if_t *gtif = &gt96100_iflist[port_num];
>>> +    struct gt96100_if_t *gtifs = pci_get_drvdata(pdev);
>>> +    struct gt96100_if_t *gtif = &gtifs[port_num];
>>>      int phy_addr, phy_id1, phy_id2;
>>>      u32 phyAD;
>>> -    int retval;
>>> +    int retval = -ENOMEM;
>>>      unsigned char chip_rev;
>>>      struct net_device *dev = NULL;
>>>           if (gtif->irq < 0) {
>>> -        printk(KERN_ERR "%s: irq unknown - probing not supported\n",
>>> -              __FUNCTION__);
>>> +        dev_err(&pdev->dev, "irq unknown - probing not supported\n");
>>>          return -ENODEV;
>>>      }
>>> +
>>> +    retval = pci_enable_device(pdev);
>>> +    if (retval) {
>>> +        dev_err(&pdev->dev, "cannot enable pci device\n");
>>> +        return retval;
>>> +    }
>> bug #1:  please confirm pci_enable_device() is OK on this embedded hardware
> I do not understand too much, did you mean something like this:
> } else
> 	dev_info(..., "pci device is enabled now\n");
> or?
Or..., aha, I got it now. How can I confirm?

thnaks,
-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
