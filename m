Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261380AbVBGJ3D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbVBGJ3D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 04:29:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbVBGJ3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 04:29:03 -0500
Received: from smtp-out.fr.clara.net ([212.43.194.59]:2947 "EHLO
	smtp-out.fr.clara.net") by vger.kernel.org with ESMTP
	id S261380AbVBGJ27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 04:28:59 -0500
Message-ID: <420734DC.4020900@idtect.com>
Date: Mon, 07 Feb 2005 10:29:00 +0100
From: Charles-Edouard Ruault <ce@idtect.com>
Organization: Idtect SA
User-Agent: Mozilla Thunderbird 1.0 (Macintosh/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: IO port conflict between timer & watchdog on PCISA-C800EV board ?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

i wrote a driver for the watchdog timer provided by a small form factor 
board from IEI ( the PCISA-C800EV : 
http://www.iei.com.tw/en/product_IPC.asp?model=PCISA-C800 ).
This board has a Via Apollo PLE133 ( VT8601A and VT82C686B ) chipset.
The watchdog uses two registers at addresses 0x43 and 0x443, therefore 
my driver tries to get bot addresses for its own use calling
request_region(0x43, 1, "watchdog" ) and request_region(0x443, 1, 
"watchdog").
The first call to request 0x43 fails because the address has already 
been allocated to the timer ( /proc/ioports shows 0040-005f : timer ).

So my questions are :
- Why is the generic timer using this address ? isn't it reserving a too 
wide portion of IO ports ? Should it be modified for this board ?
-  If there's a good reason for the timer to request this address, is  
there a clean way to share it with the timer ?

Thanks for your answers.
Regards.
PS: Please CC me to your replies, i'm not on the list.

-- 
Charles-Edouard Ruault
Idtect SA
115 rue Reaumur - 75002, Paris, France
Tel: +33-1-55-34-76-65
Fax: +33-1-55-34-76-75
Web: http://www.idtect.com

