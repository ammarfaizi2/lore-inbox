Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263413AbREXIgX>; Thu, 24 May 2001 04:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263414AbREXIgN>; Thu, 24 May 2001 04:36:13 -0400
Received: from wisdn-0.gus.net ([208.146.196.17]:49675 "EHLO
	cerberus.stardot-tech.com") by vger.kernel.org with ESMTP
	id <S263413AbREXIf6>; Thu, 24 May 2001 04:35:58 -0400
Date: Thu, 24 May 2001 01:35:33 -0700 (PDT)
From: Jim Treadway <jim@stardot-tech.com>
To: Praveen Srinivasan <praveens@stanford.edu>
cc: <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
        <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] DAC960.c - Null ptr fixes
In-Reply-To: <200105240720.f4O7KJ403429@smtp1.Stanford.EDU>
Message-ID: <Pine.LNX.4.33.0105240132360.9779-100000@cerberus.stardot-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 May 2001, Praveen Srinivasan wrote:

> Hi,
> Using the Stanford checker, we searched for null-pointer bugs in the linux
> kernel code. This patch fixes numerous unchecked pointers in the DAC960
> driver (DAC960.c).
>
> Praveen Srinivasan and Frederick Akalin
>
>
> --- ../linux/./drivers/block/DAC960.c	Tue Feb 20 21:26:22 2001
> +++ ./drivers/block/DAC960.c	Mon May  7 21:56:30 2001
> @@ -508,6 +508,9 @@
>    DAC960_Command_T *Command = DAC960_AllocateCommand(Controller);
>    DAC960_V1_CommandMailbox_T *CommandMailbox = &Command->V1.CommandMailbox;
>    DAC960_V1_CommandStatus_T CommandStatus;
> +  if(Command == NULL) {
> +    return 0;
> +  }
>    DAC960_V1_ClearCommand(Command);
>    Command->CommandType = DAC960_ImmediateCommand;
>    CommandMailbox->Type3.CommandOpcode = CommandOpcode;

[other similar examples snipped]

Shouldn't the check for NULL occur before '&Command->V1.CommandMailbox'?


