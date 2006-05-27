Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964960AbWE0XMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964960AbWE0XMz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 19:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964966AbWE0XMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 19:12:55 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:13726 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964960AbWE0XMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 19:12:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:x-enigmail-version:content-type:content-transfer-encoding;
        b=MkFhWQHfhafpN4dKQg8OM20p8FlYd/GAoGlqP7ESXGMhrvRTrZrGFErxqPpPdKdVWlHoA6FT8yrWciwAdN3ZSWRDsmx07h9LmS7wmmgG7M7egSBN6tkKxmCiu7yn7k2HoSMyGYQVVlh94MPMwPoHQUGC9Sb7pYLMMYE9iGeeXqQ=
Message-ID: <4478DCF1.8080608@gmail.com>
Date: Sun, 28 May 2006 01:12:26 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Jeff Garzik <jgarzik@pobox.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       Greg KH <gregkh@suse.de>
Subject: searching for pci busses
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I want to ask, if there is any function to call (as we debated with Jeff), which
does something like this:
1) I have some vendor/device ids in table
2) I want to traverse raws of the table and compare to system devices, and if
found, stop and return pci_dev struct (or raw in the table).
I have this code for the time being:

static struct pci_device_id ids[] = {
    { PCI_DEVICE(0x1234, 0x4321) },
    /* ... whatever ... */
    { 0 }
};

for (id = ids; id->vendor; id++) {
  d = pci_get_device(id->vendor, id->device, NULL);
  if (d != NULL) {
    /* get some info */
    pci_dev_put(d);
    break;
  }
}

I'm searching for a bus or something, which is only one in the system, but would
be made by more vendors.
Simply, something like pci_dev_present(), but with a result of pci_dev or index
of the raw in the ids table corresponding to the found device (instead of
returning 0/1).

thanks,
-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
