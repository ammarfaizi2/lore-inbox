Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135704AbRDXS1J>; Tue, 24 Apr 2001 14:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135707AbRDXS07>; Tue, 24 Apr 2001 14:26:59 -0400
Received: from mailproxy.de.uu.net ([192.76.144.34]:17863 "EHLO
	mailproxy.de.uu.net") by vger.kernel.org with ESMTP
	id <S135704AbRDXS0r>; Tue, 24 Apr 2001 14:26:47 -0400
Content-Type: text/plain; charset=US-ASCII
From: Tim Jansen <tim@tjansen.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Device Registry (DevReg) Patch 0.2.0
Date: Tue, 24 Apr 2001 20:27:07 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <01042403082000.05529@cookie> <01042413442601.00792@cookie> <3AE5AC3B.7D117951@evision-ventures.com>
In-Reply-To: <3AE5AC3B.7D117951@evision-ventures.com>
MIME-Version: 1.0
Message-Id: <01042420270701.00781@cookie>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 24 April 2001 18:39, Martin Dalecki wrote:
> Are there alternatives to get complex and extendable information out to 
> user space?
> Yes filesystem structures. 


How exactly can this work? A single value per file is not very helpful if you 
have a thousand values. You could cluster them (for example one level in the 
XML hierarchy == one file), but this will soon get very complicated. Its much 
more work to implement in the kernel, its painful in user-space and you cant 
just use a text editor to look at it (because you always have to look at 10 
files per device). 
IMHO only a single XML file per physical device is an option, but I do not 
know how to name the files...


> Or just simple parsing in the user space plain binary data.

This would be a compatibility nightmare and hard to maintain. Once you 
decided for a binary format you cannot change or extend it without breaking 
user-space apps. This may save a few lines code, but not many. All you need 
to add a line to XML output is a sprintf and a call to devreg_write_line(). 

One of the ideas of devreg is that while it has a common format for generic 
information, like the name and topology of physical devices, every driver can 
add additional data (this is why XML namespaces are used). Currently only the 
USB and PCI subsystems add data to devreg, but in future versions the device 
driver itself or other subsystems should do this, too. 

bye...
