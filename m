Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261535AbREUQ5t>; Mon, 21 May 2001 12:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261578AbREUQ5j>; Mon, 21 May 2001 12:57:39 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:35995 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S261535AbREUQ50>; Mon, 21 May 2001 12:57:26 -0400
From: Christoph Rohland <cr@sap.com>
To: Pierre Etchemaite <petchema@concept-micro.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: tmpfs + sendfile bug ?
In-Reply-To: <XFMail.20010521183553.petchema@concept-micro.com>
Organisation: SAP LinuxLab
Date: 21 May 2001 18:57:07 +0200
In-Reply-To: <XFMail.20010521183553.petchema@concept-micro.com>
Message-ID: <m3bsomwsgs.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

On Mon, 21 May 2001, Pierre Etchemaite wrote:
> I just found a problem GETting a file stored in tmpfs using proftpd;
> I always get a "426 Transfer aborted. Data connection closed."
> 
> That could be a bug with tmpfs and sendfile in 2.4.5-pre4 :
> 
> [...]
> read(8, "%PDF-1.4\r%\342\343\317\323\r\n870 0 obj\r<< \r/L"..., 8192) = 8192
> shmat(11, 0x4cfe65, 0x3)                = 0xbffff4d4
> sendfile(11, 8, [0], 5045861)           = -1 EINVAL (Invalid argument)
> [...]
> 
> Any idea ?

That's probably the same reason why tmpfs and loopback do not work
together:

tmpfs does not provide the necessary functions for sendfile and lo:
readpage, prepare_write and commitwrite.

And I do not see a way how to provide readpage in tmpfs :-(

Greetings
		Christoph


