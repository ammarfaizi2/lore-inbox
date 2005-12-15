Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161045AbVLOEld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161045AbVLOEld (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 23:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161047AbVLOEld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 23:41:33 -0500
Received: from smtp.osdl.org ([65.172.181.4]:17846 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161045AbVLOElc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 23:41:32 -0500
Date: Wed, 14 Dec 2005 20:40:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ashutosh Naik <ashutosh.naik@gmail.com>
Cc: rusty@rustcorp.com.au, jesper.juhl@gmail.com, anandhkrishnan@yahoo.co.in,
       linux-kernel@vger.kernel.org, rth@redhat.com, greg@kroah.com,
       alan@lxorguk.ukuu.org.uk, kaos@ocs.com.au
Subject: Re: [RFC][PATCH] Prevent overriding of Symbols in the Kernel,
 avoiding Undefined behaviour
Message-Id: <20051214204032.57c4c6ae.akpm@osdl.org>
In-Reply-To: <81083a450512132102g77f4a92kc894fcda9e9dc2a6@mail.gmail.com>
References: <81083a450512120439h69ccf938m12301985458ea69f@mail.gmail.com>
	<1134424878.22036.13.camel@localhost.localdomain>
	<81083a450512130626x417d86c9w31f300555c99fdb2@mail.gmail.com>
	<9a8748490512130849o73c14313l166e6dd360f32d70@mail.gmail.com>
	<1134525816.30383.13.camel@localhost.localdomain>
	<81083a450512132010t2596046bsf7a36f85df19b89c@mail.gmail.com>
	<81083a450512132102g77f4a92kc894fcda9e9dc2a6@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ashutosh Naik <ashutosh.naik@gmail.com> wrote:
>
> This patch ensures that an exported symbol  does not already exist in
>  the kernel or in some other module's exported symbol table. This is
>  done by checking the symbol tables for the exported symbol at the time
>  of loading the module. Currently this is done after the relocation of
>  the symbol.

This patch causes weird things to happen on ppc64.

The only module which is loaded is autofs, and I assume this happens when
autofs is (successfully) loaded.  But unloading autofs and reloading autofs
does not cause a repeat.


kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
tg3: eth0: Link is up at 100 Mbps, full duplex.
tg3: eth0: Flow control is off for TX and off for RX.
sunrpc: exports duplicate symbol rpc_max_payload (owned by autofs)
lockd: Unknown symbol svc_recv
lockd: Unknown symbol svc_create
lockd: Unknown symbol rpciod_up
lockd: Unknown symbol rpc_destroy_client
lockd: Unknown symbol xdr_encode_netobj
lockd: Unknown symbol svc_destroy
lockd: Unknown symbol xprt_create_proto
lockd: Unknown symbol rpc_delay
lockd: Unknown symbol rpc_call_async
lockd: Unknown symbol rpc_create_client
lockd: Unknown symbol svc_makesock
lockd: Unknown symbol nlm_debug
lockd: Unknown symbol xdr_decode_netobj
lockd: Unknown symbol svc_wake_up
lockd: Unknown symbol rpciod_down
lockd: Unknown symbol svc_exit_thread
lockd: Unknown symbol xdr_encode_string
lockd: Unknown symbol rpc_call_sync
lockd: Unknown symbol xdr_decode_string_inplace
lockd: Unknown symbol svc_set_client
lockd: Unknown symbol svc_process
lockd: Unknown symbol xprt_set_timeout
lockd: Unknown symbol rpc_restart_call
lockd: Unknown symbol svc_create_thread
exportfs: exports duplicate symbol find_exported_dentry (owned by autofs)
sunrpc: exports duplicate symbol rpc_max_payload (owned by autofs)
lockd: Unknown symbol svc_recv
lockd: Unknown symbol svc_create
lockd: Unknown symbol rpciod_up
lockd: Unknown symbol rpc_destroy_client
lockd: Unknown symbol xdr_encode_netobj
lockd: Unknown symbol svc_destroy
lockd: Unknown symbol xprt_create_proto
lockd: Unknown symbol rpc_delay
lockd: Unknown symbol rpc_call_async
lockd: Unknown symbol rpc_create_client
lockd: Unknown symbol svc_makesock
lockd: Unknown symbol nlm_debug
lockd: Unknown symbol xdr_decode_netobj
lockd: Unknown symbol svc_wake_up
lockd: Unknown symbol rpciod_down
lockd: Unknown symbol svc_exit_thread
lockd: Unknown symbol xdr_encode_string
lockd: Unknown symbol rpc_call_sync
lockd: Unknown symbol xdr_decode_string_inplace
lockd: Unknown symbol svc_set_client
lockd: Unknown symbol svc_process
lockd: Unknown symbol xprt_set_timeout
lockd: Unknown symbol rpc_restart_call
lockd: Unknown symbol svc_create_thread
exportfs: exports duplicate symbol find_exported_dentry (owned by autofs)
nfsd: Unknown symbol cache_flush
nfsd: Unknown symbol find_exported_dentry
nfsd: Unknown symbol rpcauth_lookup_credcache
nfsd: Unknown symbol svc_proc_register
nfsd: Unknown symbol cache_register
nfsd: Unknown symbol svc_recv
nfsd: Unknown symbol svc_create
nfsd: Unknown symbol svcauth_unix_purge
nfsd: Unknown symbol rpciod_up
nfsd: Unknown symbol xdr_encode_opaque
nfsd: Unknown symbol xdr_reserve_space
nfsd: Unknown symbol svc_destroy
nfsd: Unknown symbol cache_fresh
nfsd: Unknown symbol auth_domain_put
nfsd: Unknown symbol xdr_inline_decode
nfsd: Unknown symbol xprt_create_proto
nfsd: Unknown symbol nfsd_debug
nfsd: Unknown symbol rpc_call_async
nfsd: Unknown symbol svc_makesock
nfsd: Unknown symbol auth_unix_lookup
nfsd: Unknown symbol svc_seq_show
nfsd: Unknown symbol unix_domain_find
nfsd: Unknown symbol auth_unix_forget_old
nfsd: Unknown symbol svc_proc_unregister
nfsd: Unknown symbol auth_unix_add_addr
nfsd: Unknown symbol cache_init
nfsd: Unknown symbol qword_get
nfsd: Unknown symbol rpc_shutdown_client
nfsd: Unknown symbol rpciod_down
nfsd: Unknown symbol put_rpccred
nfsd: Unknown symbol svc_exit_thread
nfsd: Unknown symbol svc_set_client
nfsd: Unknown symbol lockd_down
nfsd: Unknown symbol xdr_init_decode
nfsd: Unknown symbol cache_unregister
nfsd: Unknown symbol qword_add
nfsd: Unknown symbol lockd_up
nfsd: Unknown symbol nlmsvc_ops
nfsd: Unknown symbol xdr_init_encode
nfsd: Unknown symbol rpc_call_sync
nfsd: Unknown symbol export_op_default
nfsd: Unknown symbol xdr_decode_string_inplace
nfsd: Unknown symbol rpc_new_client
nfsd: Unknown symbol svc_process
nfsd: Unknown symbol svc_reserve
nfsd: Unknown symbol cache_purge
nfsd: Unknown symbol cache_check
nfsd: Unknown symbol qword_addhex
nfsd: Unknown symbol svc_create_thread
nfsd: Unknown symbol auth_domain_find
sunrpc: exports duplicate symbol rpc_max_payload (owned by autofs)
eth0: no IPv6 routers present

