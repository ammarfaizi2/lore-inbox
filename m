Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293538AbSCPACb>; Fri, 15 Mar 2002 19:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293540AbSCPABe>; Fri, 15 Mar 2002 19:01:34 -0500
Received: from mail.webmaster.com ([216.152.64.131]:17144 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S293542AbSCPABK> convert rfc822-to-8bit; Fri, 15 Mar 2002 19:01:10 -0500
From: David Schwartz <davids@webmaster.com>
To: <davem@redhat.com>, <alan@lxorguk.ukuu.org.uk>
CC: <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.51 (1003) - Registered Version
Date: Fri, 15 Mar 2002 16:01:07 -0800
In-Reply-To: <20020315.154527.98068496.davem@redhat.com>
Subject: Re: RFC2385 (MD5 signature in TCP packets) support
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <20020316000109.AAA685@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Mar 2002 15:45:27 -0800 (PST), David S. Miller wrote:

>>What do you think Ipsec does with an RST frame with an incorrect
>>IP-AH MD5 signature ? Exactly the same thing.

>IPsec is fundamentally different because it encapsulates all IP
>traffic, not just TCP.  The packet is killed at IP if it doesn't
>pass the signature.

	You are certainly correct that the IP layer is a better place to implement 
authentication checksums.

>>I'm not saying the RFC is a good idea (tho its a needed patch to
>>use Linux for backbone routing sanely with most vendors BGP
>>kit). Your argument about the RST frame is however pure horseshit

>I totally disagree.

>Look, TCP is the last place more complexity needs to exist.
>Errors in logic in TCP need to be dealt with by breaking the
>connection and spitting a RST out, and it must be done in a
>way that is as easy to verify as possible.

	I don't follow the logic of this argument. When you receive the initial SYN, 
you'll either be able to confirm its checksum or not. Once you can confirm 
the checksum, you know that the key is the same on both ends, so there's no 
fear that a valid subsequent RST will be rejected.

	There is an issue at the connection establishment phase. If you receive a 
packet with a bad checksum, what do you do? There is some complexity here, 
but the obvious solutions work. If one end can correctly sign a packet, you 
know they will correctly accept a packet. Until you have received a packet 
whose checksum you have validated, you accept unvalidatable packets.

>IPSEC getting the signature wrong is more akin to getting bitstream
>corruptions from your networking card for a certain sequence of bytes.

	It really comes down to the question of what is or isn't a valid RST and 
whether TCP option specifications have the 'right' to override other 
provisions of the TCP specification.

	DS


