Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262166AbSJNUJg>; Mon, 14 Oct 2002 16:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262167AbSJNUJf>; Mon, 14 Oct 2002 16:09:35 -0400
Received: from chaos.analogic.com ([204.178.40.224]:25475 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S262166AbSJNUJc>; Mon, 14 Oct 2002 16:09:32 -0400
Date: Mon, 14 Oct 2002 16:17:47 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: "Adam J. Richter" <adam@yggdrasil.com>, eblade@blackmagik.dynup.net,
       linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
Subject: Re: Patch: linux-2.5.42/kernel/sys.c - warm reboot should not suspend devices
In-Reply-To: <m1smz8kegf.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.3.95.1021014160936.16867A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 Oct 2002, Eric W. Biederman wrote:

> 
> So in summary.
> - Asserting the system level reset line is the most reliable way to
>   reboot.  
[SNIPPED...to save space]

I think you can get all the PCI Bus-Masters shut off simply
by writing PCI device 0 (The bridge itself) command register
to 0.

This is what I do in my BIOS (Intel dest<--source):

;-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
;
;	The PCI bus may be on from a previous boot or from a failure to
;	reset. This causes a lot of problems that took me weeks to find.
;	Make sure the damn thing is dead, dead, dead before we continue.
;	It is not sufficient to just clear SYSARBMEMB as the documentation
;	shows. PCI devices will "jabber", corrupting data if the host
;	bridge is not turned off.
;
	MOV	DX,PCICFGADR			; PCI configuration address
	MOV	EAX,80000004H			; Enable, index 1 (command)
	OUT	DX,EAX				; Set index register
	MOV	DX,PCICFGDATA			; Data address
	IN	EAX,DX				; Get status/command
	AND	EAX,0FFFF0000H			; Really turn it OFF
	OUT	DX,EAX				; This should do it.
;
	MOV	WORD PTR DS:[SYSARBMEMB],00H	; Now disable PCI access
	MOV	DX,PCICFGADR			; PCI configuration address
	MOV	EAX,80000000H			; Enable, index 0
	OUT	DX,EAX				; Set index register
	MOV	DX,PCICFGDATA			; Data address
	IN	EAX,DX				; Get, throw away



Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

