Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262907AbTHUVuy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 17:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262910AbTHUVuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 17:50:54 -0400
Received: from smtp6.Stanford.EDU ([171.67.16.33]:54944 "EHLO
	smtp6.Stanford.EDU") by vger.kernel.org with ESMTP id S262907AbTHUVuv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 17:50:51 -0400
Date: Thu, 21 Aug 2003 14:50:44 -0700 (PDT)
From: Junfeng Yang <yjf@stanford.edu>
To: linux-kernel@vger.kernel.org
cc: mc@cs.Stanford.EDU
Subject: [CHECKER] 2 user-pointer bugs in 2.6.0-test3
Message-ID: <Pine.GSO.4.44.0308211444420.23210-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Attached are 2 user-pointer bugs in 2.6.0-test3. As usual, confirmations
or clarifications are welcomed.

-Junfeng


---------------------------------------------------------
[BUG] uioc_mimd = arg taints uioc_mimd, umc = uioc_mimd->mbox taints umc

/u1/junfeng/linux-2.6.0-test3/drivers/scsi/megaraid.c:4606:mega_n_to_m:
ERROR:TAINTED:4606:4606: dereferencing tainted ptr 'umc' [from='
/u1/junfeng/linux-2.6.0-test3/include/asm/uaccess.h:copy_from_user:parm1
arg uioc_mimd'] [Callstack: ]


		if( mc->cmd == MEGA_MBOXCMD_PASSTHRU ) {

			umc = (megacmd_t *)uioc_mimd->mbox;


Error --->
			upthru = (mega_passthru *)umc->xferaddr;

			if( put_user(mc->status, (u8
*)&upthru->scsistatus) )
				return (-EFAULT);

---------------------------------------------------------
[BUG] optlen is dereferenced in function sctp_getsockopt_peer_addr_params

/u1/junfeng/linux-2.6.0-test3/net/sctp/socket.c:3065:sctp_getsockopt:
ERROR:TAINTED:3065:3065: passing tainted ptr 'optlen' into
'sctp_getsockopt_peer_addr_params'
[to='/u1/junfeng/linux-2.6.0-test3/net/sctp/socket.c:sctp_getsockopt_peer_addr_params:3']
[from='
/u1/junfeng/linux-2.6.0-test3/net/ipv4/ipmr.c:sctp_getsockopt:parm4']
[Callstack:
/u1/junfeng/linux-2.6.0-test3/net/ipv4/tcp.c:2450:sctp_getsockopt((tainted,
4)(untainted, 0))]

		break;
	case SCTP_SOCKOPT_PEELOFF:
		retval = sctp_getsockopt_peeloff(sk, len, optval, optlen);
		break;
	case SCTP_GET_PEER_ADDR_PARAMS:

Error --->
		retval = sctp_getsockopt_peer_addr_params(sk, len, optval,
							  optlen);
		break;
	case SCTP_INITMSG:



