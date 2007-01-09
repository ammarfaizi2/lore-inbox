Return-Path: <linux-kernel-owner+w=401wt.eu-S932440AbXAIVa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbXAIVa4 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 16:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932442AbXAIVa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 16:30:56 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:52477 "EHLO e1.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932440AbXAIVaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 16:30:55 -0500
In-Reply-To: <1168312045.3180.140.camel@laptopd505.fenrus.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: akpm@osdl.org, Christoph Hellwig <hch@infradead.org>,
       kjhall@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
       safford@watson.ibm.com
MIME-Version: 1.0
Subject: Re: mprotect abuse in slim
X-Mailer: Lotus Notes Release 7.0.1P Oct 16, 2006
Message-ID: <OFCB9A1329.F623D1AA-ON8525725E.0075A270-8525725E.0076FD7E@us.ibm.com>
From: Mimi Zohar <zohar@us.ibm.com>
Date: Tue, 9 Jan 2007 16:30:54 -0500
X-MIMETrack: Serialize by Router on D01ML604/01/M/IBM(Build V80_M3_10312006|October 31, 2006) at
 01/09/2007 16:30:55,
	Serialize complete at 01/09/2007 16:30:55
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> wrote on 01/08/2007 10:07:25 PM:

> Hi,
> 
>maybe this is a silly question, but do you revoke not only the current
>fd entries, but also the ones that are pending in UNIX domain sockets
>and that are already being sent to the process? If not.. then you might
>as well not bother ;)
> 
>Greetings,
>   Arjan van de Ven

In the new slim code, which we haven't sent out but will soon, we added
the unix_may_send and unix_stream_connect hooks. The unix_may_send hook
prevents a demoted process from sending data on a higher integrity
socket; and the unix_may_connect hook prevents a process from
connecting to a lower integrity socket.  The integrity level of the
socket is based on the integrity of the file associated with the Unix
domain socket.

The bottom line is that although we don't demote the pending socket
and would allow it to connect at the higher integrity, we simply don't
allow anything of lesser integrity to be sent over it.

Mimi Zohar
