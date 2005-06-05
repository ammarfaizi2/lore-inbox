Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261548AbVFEK1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbVFEK1O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 06:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261549AbVFEK1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 06:27:14 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:32219 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S261548AbVFEK1J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 06:27:09 -0400
Message-ID: <42A2D37A.5050408@free.fr>
Date: Sun, 05 Jun 2005 12:27:06 +0200
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: Michael Tokarev <mjt@tls.msk.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: PNP parallel&serial ports: module reload fails (2.6.11)?
References: <20050602222400.GA8083@mut38-1-82-67-62-65.fbx.proxad.net> <429FA1F3.9000001@tls.msk.ru>
In-Reply-To: <429FA1F3.9000001@tls.msk.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Tokarev wrote:
> castet.matthieu@free.fr wrote:
>> And pnpacpi have some problem to activate resource with some strange 
>> acpi implementation...
> 
> 
> I haven't seen any probs with acpi or bios or other things on
> those boxen yet -- pretty good ones.  It's HP ProLiant ML150
> machine (not G2).  There are other HP machines out here which
> also shows the same problem - eg HP ProLiant ML310 G1.
> 
hpml310.dsl acpi dsdt is strange :


             Name (CRES, ResourceTemplate ()
             {
                 IRQNoFlags () {7}
                 DMA (Compatibility, NotBusMaster, Transfer8) {3}
                 IO (Decode16, 0x0378, 0x0378, 0x08, 0x08)
                 IO (Decode16, 0x0678, 0x0678, 0x00, 0x06)
             })

[...]
Name (_PRS, ResourceTemplate ()
             {
                 StartDependentFn (0x00, 0x00)
                 {
                     IO (Decode16, 0x0378, 0x0378, 0x00, 0x08)
                 }
                 StartDependentFn (0x00, 0x00)
                 {
                     IO (Decode16, 0x03BC, 0x03BC, 0x00, 0x03)
                 }
                 StartDependentFn (0x00, 0x00)
                 {
                     IO (Decode16, 0x0278, 0x0278, 0x00, 0x08)
                 }
                 EndDependentFn ()
             })

So in the list of possible resource (_PRS) there only info about one 
ioport not about the others resource. I wonder if it is really valid ?

Matthieu
