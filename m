Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261817AbUKJBXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbUKJBXu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 20:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbUKJBXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 20:23:50 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:47373 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261817AbUKJBWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 20:22:07 -0500
Date: Wed, 10 Nov 2004 02:21:34 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Len Brown <len.brown@intel.com>
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/acpi: #ifdef unused functions away
Message-ID: <20041110012134.GB4089@stusta.de>
References: <20041105215021.GF1295@stusta.de> <1099707007.13834.1969.camel@d845pe> <20041106114844.GK1295@stusta.de> <418CEE3A.40503@conectiva.com.br> <20041106212917.GP1295@stusta.de> <418D403E.30608@conectiva.com.br> <1099933263.13831.9547.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099933263.13831.9547.camel@d845pe>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2004 at 12:01:03PM -0500, Len Brown wrote:

> Thanks for the suggestion.
> 
> I'd certainly accept patches using ACPI_FUTURE_USAGE and moving
> EXPORT_KSYMS to where they're more easily tracked.

My ACPI_FUTURE_USAGE patch (applies on top of my previous patch that 
kills acpi_ksyms.c) is below.

This patch only #ifdef's completely unused code away - it does not make 
the many global functions only used inside the file they are defined in 
static.

> If the motivation is kernel static size reduction, then I'll be
> interested in seeing a before/after kernel size measurements.

(both examples with gcc 3.4.2 on i386 compiled for an Athlon)

Full .config (no module support, _everything_ possible compiled 
statically into the kernel):

530552 2004-11-10 02:04 drivers/acpi/built-in.o
556195 2004-11-09 22:50 drivers/acpi/built-in.o-before-acpi-cleanup

-> 4.8% space saving


My own kernel (minimum ACPI support statically in the kernel for a 
proper shutdown of my computer):

250235 2004-11-10 02:08 drivers/acpi/built-in.o
256262 2004-11-10 00:09 drivers/acpi/built-in.o-before-acpi-cleanup

-> 2.4% space saving


The nice thing is that we get these space savings for free.


diffstat output:
 drivers/acpi/dispatcher/dsmthdat.c |    3 ++-
 drivers/acpi/dispatcher/dswstate.c |   10 ++++++++--
 drivers/acpi/events/evxface.c      |    3 ++-
 drivers/acpi/events/evxfevnt.c     |    7 ++++++-
 drivers/acpi/executer/exdump.c     |    4 ++++
 drivers/acpi/hardware/Makefile     |    4 +++-
 drivers/acpi/hardware/hwgpe.c      |    3 ++-
 drivers/acpi/hardware/hwsleep.c    |    3 ++-
 drivers/acpi/namespace/Makefile    |    4 +++-
 drivers/acpi/namespace/nsdump.c    |    4 ++++
 drivers/acpi/namespace/nsload.c    |    4 ++++
 drivers/acpi/namespace/nsutils.c   |    3 ++-
 drivers/acpi/namespace/nsxfeval.c  |    3 ++-
 drivers/acpi/osl.c                 |    6 ++++++
 drivers/acpi/parser/pstree.c       |    4 +++-
 drivers/acpi/parser/psutils.c      |    2 ++
 drivers/acpi/pci_bind.c            |    2 ++
 drivers/acpi/resources/Makefile    |    4 +++-
 drivers/acpi/resources/rsutils.c   |    3 ++-
 drivers/acpi/resources/rsxface.c   |    3 ++-
 drivers/acpi/tables/tbutils.c      |    3 ++-
 drivers/acpi/tables/tbxface.c      |    4 ++++
 drivers/acpi/utilities/utalloc.c   |    3 ++-
 drivers/acpi/utilities/utmisc.c    |    3 ++-
 drivers/acpi/utilities/utxface.c   |    4 ++++
 include/acpi/acdispat.h            |    8 ++++++++
 include/acpi/achware.h             |    5 ++++-
 include/acpi/acinterp.h            |    3 ++-
 include/acpi/acmacros.h            |    8 ++++++++
 include/acpi/acnamesp.h            |   10 ++++++++++
 include/acpi/acparser.h            |    4 ++++
 include/acpi/acpiosxf.h            |    6 ++++++
 include/acpi/acpixf.h              |   20 ++++++++++++++++++++
 include/acpi/acresrc.h             |    4 ++++
 include/acpi/actables.h            |    2 ++
 include/acpi/acutils.h             |    6 ++++++
 include/acpi/platform/acenv.h      |    8 ++++++++
 37 files changed, 160 insertions(+), 20 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm4-full/include/acpi/acdispat.h.old	2004-11-09 22:57:58.000000000 +0100
+++ linux-2.6.10-rc1-mm4-full/include/acpi/acdispat.h	2004-11-09 23:03:38.000000000 +0100
@@ -62,10 +62,12 @@
 	u32                             pop_count,
 	struct acpi_walk_state          *walk_state);
 
+#ifdef ACPI_FUTURE_USAGE
 void *
 acpi_ds_obj_stack_get_value (
 	u32                             index,
 	struct acpi_walk_state          *walk_state);
+#endif
 
 acpi_status
 acpi_ds_obj_stack_pop_object (
@@ -248,11 +250,13 @@
 acpi_ds_is_method_value (
 	union acpi_operand_object       *obj_desc);
 
+#ifdef ACPI_FUTURE_USAGE
 acpi_object_type
 acpi_ds_method_data_get_type (
 	u16                             opcode,
 	u32                             index,
 	struct acpi_walk_state          *walk_state);
+#endif
 
 acpi_status
 acpi_ds_method_data_get_value (
@@ -440,9 +444,11 @@
 	struct acpi_parameter_info      *info,
 	u32                             pass_number);
 
+#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_ds_obj_stack_delete_all (
 	struct acpi_walk_state          *walk_state);
+#endif
 
 acpi_status
 acpi_ds_obj_stack_pop_and_delete (
@@ -482,6 +488,7 @@
 acpi_ds_delete_walk_state_cache (
 	void);
 
+#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_ds_result_insert (
 	void                            *object,
@@ -493,6 +500,7 @@
 	union acpi_operand_object       **object,
 	u32                             index,
 	struct acpi_walk_state          *walk_state);
+#endif
 
 acpi_status
 acpi_ds_result_pop (
--- linux-2.6.10-rc1-mm4-full/drivers/acpi/dispatcher/dsmthdat.c.old	2004-11-09 22:58:59.000000000 +0100
+++ linux-2.6.10-rc1-mm4-full/drivers/acpi/dispatcher/dsmthdat.c	2004-11-09 22:59:33.000000000 +0100
@@ -350,7 +350,7 @@
  * RETURN:      Data type of current value of the selected Arg or Local
  *
  ******************************************************************************/
-
+#ifdef ACPI_FUTURE_USAGE
 acpi_object_type
 acpi_ds_method_data_get_type (
 	u16                             opcode,
@@ -385,6 +385,7 @@
 
 	return_VALUE (ACPI_GET_OBJECT_TYPE (object));
 }
+#endif  /*  ACPI_FUTURE_USAGE  */
 
 
 /*******************************************************************************
--- linux-2.6.10-rc1-mm4-full/drivers/acpi/dispatcher/dswstate.c.old	2004-11-09 23:01:14.000000000 +0100
+++ linux-2.6.10-rc1-mm4-full/drivers/acpi/dispatcher/dswstate.c	2004-11-09 23:04:17.000000000 +0100
@@ -51,6 +51,8 @@
 	 ACPI_MODULE_NAME    ("dswstate")
 
 
+#ifdef ACPI_FUTURE_USAGE
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ds_result_insert
@@ -174,6 +176,8 @@
 	return (AE_OK);
 }
 
+#endif  /*  ACPI_FUTURE_USAGE  */
+
 
 /*******************************************************************************
  *
@@ -445,7 +449,7 @@
  *              Should be used with great care, if at all!
  *
  ******************************************************************************/
-
+#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_ds_obj_stack_delete_all (
 	struct acpi_walk_state          *walk_state)
@@ -467,6 +471,7 @@
 
 	return_ACPI_STATUS (AE_OK);
 }
+#endif  /*  ACPI_FUTURE_USAGE  */
 
 
 /*******************************************************************************
@@ -687,7 +692,7 @@
  *              be within the range of the current stack pointer.
  *
  ******************************************************************************/
-
+#ifdef ACPI_FUTURE_USAGE
 void *
 acpi_ds_obj_stack_get_value (
 	u32                             index,
@@ -712,6 +717,7 @@
 	return_PTR (walk_state->operands[(acpi_native_uint)(walk_state->num_operands - 1) -
 			  index]);
 }
+#endif  /*  ACPI_FUTURE_USAGE  */
 
 
 /*******************************************************************************
--- linux-2.6.10-rc1-mm4-full/include/acpi/acpixf.h.old	2004-11-09 23:05:59.000000000 +0100
+++ linux-2.6.10-rc1-mm4-full/include/acpi/acpixf.h	2004-11-10 01:27:52.000000000 +0100
@@ -70,9 +70,11 @@
 acpi_terminate (
 	void);
 
+#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_subsystem_status (
 	void);
+#endif
 
 acpi_status
 acpi_enable (
@@ -82,9 +84,11 @@
 acpi_disable (
 	void);
 
+#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_get_system_info (
 	struct acpi_buffer              *ret_buffer);
+#endif
 
 const char *
 acpi_format_exception (
@@ -94,10 +98,12 @@
 acpi_purge_cached_objects (
 	void);
 
+#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_install_initialization_handler (
 	acpi_init_handler               handler,
 	u32                             function);
+#endif
 
 /*
  * ACPI Memory manager
@@ -129,6 +135,7 @@
 acpi_load_tables (
 	void);
 
+#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_load_table (
 	struct acpi_table_header        *table_ptr);
@@ -142,6 +149,7 @@
 	acpi_table_type                 table_type,
 	u32                             instance,
 	struct acpi_table_header        *out_table_header);
+#endif  /*  ACPI_FUTURE_USAGE  */
 
 acpi_status
 acpi_get_table (
@@ -218,6 +226,7 @@
 	struct acpi_object_list         *parameter_objects,
 	struct acpi_buffer              *return_object_buffer);
 
+#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_evaluate_object_typed (
 	acpi_handle                     object,
@@ -225,6 +234,7 @@
 	struct acpi_object_list         *external_params,
 	struct acpi_buffer              *return_buffer,
 	acpi_object_type                return_type);
+#endif
 
 acpi_status
 acpi_get_object_info (
@@ -299,9 +309,11 @@
 	acpi_event_handler              address,
 	void                            *context);
 
+#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_install_exception_handler (
 	acpi_exception_handler          handler);
+#endif
 
 
 /*
@@ -333,6 +345,7 @@
 	u32                             event,
 	u32                             flags);
 
+#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_clear_event (
 	u32                             event);
@@ -341,6 +354,7 @@
 acpi_get_event_status (
 	u32                             event,
 	acpi_event_status               *event_status);
+#endif  /*  ACPI_FUTURE_USAGE  */
 
 acpi_status
 acpi_set_gpe_type (
@@ -366,6 +380,7 @@
 	u32                             gpe_number,
 	u32                             flags);
 
+#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_get_gpe_status (
 	acpi_handle                     gpe_device,
@@ -383,6 +398,7 @@
 acpi_status
 acpi_remove_gpe_block (
 	acpi_handle                     gpe_device);
+#endif  /*  ACPI_FUTURE_USAGE  */
 
 
 /*
@@ -400,10 +416,12 @@
 	acpi_handle                     device_handle,
 	struct acpi_buffer              *ret_buffer);
 
+#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_get_possible_resources(
 	acpi_handle                     device_handle,
 	struct acpi_buffer              *ret_buffer);
+#endif
 
 acpi_status
 acpi_walk_resources (
@@ -447,9 +465,11 @@
 acpi_set_firmware_waking_vector (
 	acpi_physical_address           physical_address);
 
+#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_get_firmware_waking_vector (
 	acpi_physical_address           *physical_address);
+#endif
 
 acpi_status
 acpi_get_sleep_type_data (
--- linux-2.6.10-rc1-mm4-full/drivers/acpi/events/evxface.c.old	2004-11-09 23:06:33.000000000 +0100
+++ linux-2.6.10-rc1-mm4-full/drivers/acpi/events/evxface.c	2004-11-09 23:07:05.000000000 +0100
@@ -64,7 +64,7 @@
  * DESCRIPTION: Saves the pointer to the handler function
  *
  ******************************************************************************/
-
+#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_install_exception_handler (
 	acpi_exception_handler          handler)
@@ -95,6 +95,7 @@
 	(void) acpi_ut_release_mutex (ACPI_MTX_EVENTS);
 	return_ACPI_STATUS (status);
 }
+#endif  /*  ACPI_FUTURE_USAGE  */
 
 
 /*******************************************************************************
--- linux-2.6.10-rc1-mm4-full/drivers/acpi/events/evxfevnt.c.old	2004-11-09 23:07:56.000000000 +0100
+++ linux-2.6.10-rc1-mm4-full/drivers/acpi/events/evxfevnt.c	2004-11-09 23:10:03.000000000 +0100
@@ -435,7 +435,7 @@
  * DESCRIPTION: Clear an ACPI event (fixed)
  *
  ******************************************************************************/
-
+#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_clear_event (
 	u32                             event)
@@ -462,6 +462,7 @@
 	return_ACPI_STATUS (status);
 }
 EXPORT_SYMBOL(acpi_clear_event);
+#endif  /*  ACPI_FUTURE_USAGE  */
 
 
 /*******************************************************************************
@@ -518,6 +519,8 @@
 }
 
 
+#ifdef ACPI_FUTURE_USAGE
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_get_event_status
@@ -774,3 +777,5 @@
 }
 EXPORT_SYMBOL(acpi_remove_gpe_block);
 
+#endif  /*  ACPI_FUTURE_USAGE  */
+
--- linux-2.6.10-rc1-mm4-full/include/acpi/acinterp.h.old	2004-11-09 23:14:33.000000000 +0100
+++ linux-2.6.10-rc1-mm4-full/include/acpi/acinterp.h	2004-11-09 23:18:00.000000000 +0100
@@ -504,6 +504,7 @@
 	char                            *module_name,
 	u32                             line_number);
 
+#ifdef ACPI_FUTURE_USAGE
 void
 acpi_ex_dump_object_descriptor (
 	union acpi_operand_object       *object,
@@ -533,7 +534,7 @@
 acpi_ex_out_address (
 	char                            *title,
 	acpi_physical_address           value);
-
+#endif  /*  ACPI_FUTURE_USAGE  */
 
 /*
  * exnames - interpreter/scanner name load/execute
--- linux-2.6.10-rc1-mm4-full/drivers/acpi/executer/exdump.c.old	2004-11-09 23:13:44.000000000 +0100
+++ linux-2.6.10-rc1-mm4-full/drivers/acpi/executer/exdump.c	2004-11-09 23:17:42.000000000 +0100
@@ -438,6 +438,8 @@
 }
 
 
+#ifdef ACPI_FUTURE_USAGE
+
 /*****************************************************************************
  *
  * FUNCTION:    acpi_ex_out*
@@ -786,5 +788,7 @@
 	return_VOID;
 }
 
+#endif  /*  ACPI_FUTURE_USAGE  */
+
 #endif
 
--- linux-2.6.10-rc1-mm4-full/drivers/acpi/hardware/hwsleep.c.old	2004-11-09 23:38:42.000000000 +0100
+++ linux-2.6.10-rc1-mm4-full/drivers/acpi/hardware/hwsleep.c	2004-11-09 23:39:04.000000000 +0100
@@ -112,7 +112,7 @@
  * DESCRIPTION: Access function for firmware_waking_vector field in FACS
  *
  ******************************************************************************/
-
+#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_get_firmware_waking_vector (
 	acpi_physical_address *physical_address)
@@ -138,6 +138,7 @@
 
 	return_ACPI_STATUS (AE_OK);
 }
+#endif
 
 
 /******************************************************************************
--- linux-2.6.10-rc1-mm4-full/include/acpi/achware.h.old	2004-11-09 23:39:24.000000000 +0100
+++ linux-2.6.10-rc1-mm4-full/include/acpi/achware.h	2004-11-10 01:57:41.000000000 +0100
@@ -131,10 +131,12 @@
 	struct acpi_gpe_xrupt_info      *gpe_xrupt_info,
 	struct acpi_gpe_block_info      *gpe_block);
 
+#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_hw_get_gpe_status (
 	struct acpi_gpe_event_info      *gpe_event_info,
 	acpi_event_status               *event_status);
+#endif
 
 acpi_status
 acpi_hw_disable_all_gpes (
@@ -161,6 +163,7 @@
 
 /* ACPI Timer prototypes */
 
+#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_get_timer_resolution (
 	u32                             *resolution);
@@ -174,6 +177,6 @@
 	u32                             start_ticks,
 	u32                             end_ticks,
 	u32                             *time_elapsed);
-
+#endif  /*  ACPI_FUTURE_USAGE  */
 
 #endif /* __ACHWARE_H__ */
--- linux-2.6.10-rc1-mm4-full/drivers/acpi/hardware/Makefile.old	2004-11-09 23:40:15.000000000 +0100
+++ linux-2.6.10-rc1-mm4-full/drivers/acpi/hardware/Makefile	2004-11-09 23:40:52.000000000 +0100
@@ -2,6 +2,8 @@
 # Makefile for all Linux ACPI interpreter subdirectories
 #
 
-obj-y := hwacpi.o  hwgpe.o  hwregs.o  hwsleep.o  hwtimer.o
+obj-y := hwacpi.o  hwgpe.o  hwregs.o  hwsleep.o
+
+obj-$(ACPI_FUTURE_USAGE) += hwtimer.o
 
 EXTRA_CFLAGS += $(ACPI_CFLAGS)
--- linux-2.6.10-rc1-mm4-full/include/acpi/acmacros.h.old	2004-11-09 23:43:54.000000000 +0100
+++ linux-2.6.10-rc1-mm4-full/include/acpi/acmacros.h	2004-11-09 23:44:51.000000000 +0100
@@ -538,7 +538,11 @@
 
 
 #define ACPI_DUMP_ENTRY(a,b)            acpi_ns_dump_entry (a,b)
+
+#ifdef ACPI_FUTURE_USAGE
 #define ACPI_DUMP_TABLES(a,b)           acpi_ns_dump_tables(a,b)
+#endif
+
 #define ACPI_DUMP_PATHNAME(a,b,c,d)     acpi_ns_dump_pathname(a,b,c,d)
 #define ACPI_DUMP_RESOURCE_LIST(a)      acpi_rs_dump_resource_list(a)
 #define ACPI_DUMP_BUFFER(a,b)           acpi_ut_dump_buffer((u8 *)a,b,DB_BYTE_DISPLAY,_COMPONENT)
@@ -591,7 +595,11 @@
 #define ACPI_DUMP_STACK_ENTRY(a)
 #define ACPI_DUMP_OPERANDS(a,b,c,d,e)
 #define ACPI_DUMP_ENTRY(a,b)
+
+#ifdef ACPI_FUTURE_USAGE
 #define ACPI_DUMP_TABLES(a,b)
+#endif
+
 #define ACPI_DUMP_PATHNAME(a,b,c,d)
 #define ACPI_DUMP_RESOURCE_LIST(a)
 #define ACPI_DUMP_BUFFER(a,b)
--- linux-2.6.10-rc1-mm4-full/include/acpi/acnamesp.h.old	2004-11-09 23:44:55.000000000 +0100
+++ linux-2.6.10-rc1-mm4-full/include/acpi/acnamesp.h	2004-11-10 00:02:03.000000000 +0100
@@ -210,6 +210,7 @@
  * Namespace modification - nsmodify
  */
 
+#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_ns_unload_namespace (
 	acpi_handle                     handle);
@@ -217,16 +218,19 @@
 acpi_status
 acpi_ns_delete_subtree (
 	acpi_handle                     start_handle);
+#endif
 
 
 /*
  * Namespace dump/print utilities - nsdump
  */
 
+#ifdef ACPI_FUTURE_USAGE
 void
 acpi_ns_dump_tables (
 	acpi_handle                     search_base,
 	u32                             max_depth);
+#endif
 
 void
 acpi_ns_dump_entry (
@@ -245,6 +249,7 @@
 	u32                             num_segments,
 	char                            *pathname);
 
+#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_ns_dump_one_device (
 	acpi_handle                     obj_handle,
@@ -255,6 +260,7 @@
 void
 acpi_ns_dump_root_devices (
 	void);
+#endif  /*  ACPI_FUTURE_USAGE  */
 
 acpi_status
 acpi_ns_dump_one_object (
@@ -263,6 +269,7 @@
 	void                            *context,
 	void                            **return_value);
 
+#ifdef ACPI_FUTURE_USAGE
 void
 acpi_ns_dump_objects (
 	acpi_object_type                type,
@@ -270,6 +277,7 @@
 	u32                             max_depth,
 	u32                             ownder_id,
 	acpi_handle                     start_handle);
+#endif
 
 
 /*
@@ -303,9 +311,11 @@
  * Parent/Child/Peer utility functions
  */
 
+#ifdef ACPI_FUTURE_USAGE
 acpi_name
 acpi_ns_find_parent_name (
 	struct acpi_namespace_node      *node_to_search);
+#endif
 
 
 /*
--- linux-2.6.10-rc1-mm4-full/drivers/acpi/namespace/nsdump.c.old	2004-11-09 23:52:20.000000000 +0100
+++ linux-2.6.10-rc1-mm4-full/drivers/acpi/namespace/nsdump.c	2004-11-09 23:48:07.000000000 +0100
@@ -550,6 +550,8 @@
 }
 
 
+#ifdef ACPI_FUTURE_USAGE
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ns_dump_objects
@@ -635,6 +637,8 @@
 	return_VOID;
 }
 
+#endif  /*  ACPI_FUTURE_USAGE  */
+
 
 /*******************************************************************************
  *
--- linux-2.6.10-rc1-mm4-full/drivers/acpi/namespace/Makefile.old	2004-11-09 23:50:33.000000000 +0100
+++ linux-2.6.10-rc1-mm4-full/drivers/acpi/namespace/Makefile	2004-11-09 23:51:18.000000000 +0100
@@ -2,9 +2,11 @@
 # Makefile for all Linux ACPI interpreter subdirectories
 #
 
-obj-y := nsaccess.o  nsdumpdv.o  nsload.o    nssearch.o  nsxfeval.o \
+obj-y := nsaccess.o  nsload.o    nssearch.o  nsxfeval.o \
 	 nsalloc.o   nseval.o    nsnames.o   nsutils.o   nsxfname.o \
 	 nsdump.o    nsinit.o    nsobject.o  nswalk.o    nsxfobj.o  \
 	 nsparse.o
 
+obj-$(ACPI_FUTURE_USAGE) += nsdumpdv.o
+
 EXTRA_CFLAGS += $(ACPI_CFLAGS)
--- linux-2.6.10-rc1-mm4-full/drivers/acpi/namespace/nsload.c.old	2004-11-09 23:57:35.000000000 +0100
+++ linux-2.6.10-rc1-mm4-full/drivers/acpi/namespace/nsload.c	2004-11-09 23:57:23.000000000 +0100
@@ -321,6 +321,8 @@
 }
 
 
+#ifdef ACPI_FUTURE_USAGE
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ns_delete_subtree
@@ -452,5 +454,7 @@
 	return_ACPI_STATUS (status);
 }
 
+#endif  /*  ACPI_FUTURE_USAGE  */
+
 #endif
 
--- linux-2.6.10-rc1-mm4-full/drivers/acpi/namespace/nsutils.c.old	2004-11-09 23:59:26.000000000 +0100
+++ linux-2.6.10-rc1-mm4-full/drivers/acpi/namespace/nsutils.c	2004-11-10 00:01:38.000000000 +0100
@@ -961,7 +961,7 @@
  *              (which "should not happen").
  *
  ******************************************************************************/
-
+#ifdef ACPI_FUTURE_USAGE
 acpi_name
 acpi_ns_find_parent_name (
 	struct acpi_namespace_node      *child_node)
@@ -994,6 +994,7 @@
 
 	return_VALUE (ACPI_UNKNOWN_NAME);
 }
+#endif
 
 
 /*******************************************************************************
--- linux-2.6.10-rc1-mm4-full/drivers/acpi/namespace/nsxfeval.c.old	2004-11-10 00:02:29.000000000 +0100
+++ linux-2.6.10-rc1-mm4-full/drivers/acpi/namespace/nsxfeval.c	2004-11-10 00:03:10.000000000 +0100
@@ -73,7 +73,7 @@
  *              be valid (non-null)
  *
  ******************************************************************************/
-
+#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_evaluate_object_typed (
 	acpi_handle                     handle,
@@ -144,6 +144,7 @@
 	return_buffer->length = 0;
 	return_ACPI_STATUS (AE_TYPE);
 }
+#endif  /*  ACPI_FUTURE_USAGE  */
 
 
 /*******************************************************************************
--- linux-2.6.10-rc1-mm4-full/include/acpi/acpiosxf.h.old	2004-11-10 00:07:23.000000000 +0100
+++ linux-2.6.10-rc1-mm4-full/include/acpi/acpiosxf.h	2004-11-10 00:09:31.000000000 +0100
@@ -176,10 +176,12 @@
 	void __iomem                  *logical_address,
 	acpi_size                       size);
 
+#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_os_get_physical_address (
 	void                            *logical_address,
 	acpi_physical_address           *physical_address);
+#endif
 
 
 /*
@@ -302,10 +304,12 @@
 	void                            *pointer,
 	acpi_size                       length);
 
+#ifdef ACPI_FUTURE_USAGE
 u8
 acpi_os_writable (
 	void                            *pointer,
 	acpi_size                       length);
+#endif
 
 u64
 acpi_os_get_timer (
@@ -339,9 +343,11 @@
  * Debug input
  */
 
+#ifdef ACPI_FUTURE_USAGE
 u32
 acpi_os_get_line (
 	char                            *buffer);
+#endif
 
 
 /*
--- linux-2.6.10-rc1-mm4-full/drivers/acpi/osl.c.old	2004-11-10 00:06:09.000000000 +0100
+++ linux-2.6.10-rc1-mm4-full/drivers/acpi/osl.c	2004-11-10 00:09:12.000000000 +0100
@@ -211,6 +211,7 @@
 	iounmap(virt);
 }
 
+#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_os_get_physical_address(void *virt, acpi_physical_address *phys)
 {
@@ -221,6 +222,7 @@
 
 	return AE_OK;
 }
+#endif
 
 #define ACPI_MAX_OVERRIDE_LEN 100
 
@@ -989,6 +991,7 @@
 }
 EXPORT_SYMBOL(acpi_os_signal_semaphore);
 
+#ifdef ACPI_FUTURE_USAGE
 u32
 acpi_os_get_line(char *buffer)
 {
@@ -1007,6 +1010,7 @@
 
 	return 0;
 }
+#endif  /*  ACPI_FUTURE_USAGE  */
 
 /* Assumes no unreadable holes inbetween */
 u8
@@ -1019,6 +1023,7 @@
 	return 1;
 }
 
+#ifdef ACPI_FUTURE_USAGE
 u8
 acpi_os_writable(void *ptr, acpi_size len)
 {
@@ -1026,6 +1031,7 @@
 	   The later may be difficult at early boot when kmap doesn't work yet. */
 	return 1;
 }
+#endif
 
 u32
 acpi_os_get_thread_id (void)
--- linux-2.6.10-rc1-mm4-full/include/acpi/acparser.h.old	2004-11-10 00:13:14.000000000 +0100
+++ linux-2.6.10-rc1-mm4-full/include/acpi/acparser.h	2004-11-10 00:15:57.000000000 +0100
@@ -247,6 +247,7 @@
 	union acpi_parse_object         *op,
 	u32                              argn);
 
+#ifdef ACPI_FUTURE_USAGE
 union acpi_parse_object *
 acpi_ps_get_child (
 	union acpi_parse_object         *op);
@@ -255,6 +256,7 @@
 acpi_ps_get_depth_next (
 	union acpi_parse_object         *origin,
 	union acpi_parse_object         *op);
+#endif  /*  ACPI_FUTURE_USAGE  */
 
 
 /* pswalk - parse tree walk routines */
@@ -313,9 +315,11 @@
 acpi_ps_is_prefix_char (
 	u32                             c);
 
+#ifdef ACPI_FUTURE_USAGE
 u32
 acpi_ps_get_name(
 	union acpi_parse_object         *op);
+#endif
 
 void
 acpi_ps_set_name(
--- linux-2.6.10-rc1-mm4-full/drivers/acpi/parser/pstree.c.old	2004-11-10 00:13:48.000000000 +0100
+++ linux-2.6.10-rc1-mm4-full/drivers/acpi/parser/pstree.c	2004-11-10 00:14:57.000000000 +0100
@@ -181,6 +181,8 @@
 }
 
 
+#ifdef ACPI_FUTURE_USAGE
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ps_get_child
@@ -192,7 +194,6 @@
  * DESCRIPTION: Get op's children or NULL if none
  *
  ******************************************************************************/
-
 union acpi_parse_object *
 acpi_ps_get_child (
 	union acpi_parse_object         *op)
@@ -322,4 +323,5 @@
 	return (next);
 }
 
+#endif  /*  ACPI_FUTURE_USAGE  */
 
--- linux-2.6.10-rc1-mm4-full/drivers/acpi/parser/psutils.c.old	2004-11-10 00:16:07.000000000 +0100
+++ linux-2.6.10-rc1-mm4-full/drivers/acpi/parser/psutils.c	2004-11-10 00:16:28.000000000 +0100
@@ -267,6 +267,7 @@
 /*
  * Get op's name (4-byte name segment) or 0 if unnamed
  */
+#ifdef ACPI_FUTURE_USAGE
 u32
 acpi_ps_get_name (
 	union acpi_parse_object         *op)
@@ -283,6 +284,7 @@
 
 	return (op->named.name);
 }
+#endif  /*  ACPI_FUTURE_USAGE  */
 
 
 /*
--- linux-2.6.10-rc1-mm4-full/drivers/acpi/pci_bind.c.old	2004-11-10 00:18:17.000000000 +0100
+++ linux-2.6.10-rc1-mm4-full/drivers/acpi/pci_bind.c	2004-11-10 00:22:00.000000000 +0100
@@ -67,6 +67,7 @@
  * to resolve PCI information for ACPI-PCI devices defined in the namespace.
  * This typically occurs when resolving PCI operation region information.
  */
+#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_os_get_pci_id (
 	acpi_handle		handle,
@@ -114,6 +115,7 @@
 
 	return_ACPI_STATUS(AE_OK);
 }
+#endif  /*  ACPI_FUTURE_USAGE  */
 
 	
 int
--- linux-2.6.10-rc1-mm4-full/include/acpi/acresrc.h.old	2004-11-10 02:02:19.000000000 +0100
+++ linux-2.6.10-rc1-mm4-full/include/acpi/acresrc.h	2004-11-10 01:59:58.000000000 +0100
@@ -60,10 +60,12 @@
 	acpi_handle                     handle,
 	struct acpi_buffer              *ret_buffer);
 
+#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_rs_get_prs_method_data (
 	acpi_handle                     handle,
 	struct acpi_buffer              *ret_buffer);
+#endif
 
 acpi_status
 acpi_rs_get_method_data (
@@ -95,6 +97,7 @@
 /*
  * Function prototypes called from acpi_rs_create*
  */
+#ifdef ACPI_FUTURE_USAGE
 void
 acpi_rs_dump_irq (
 	union acpi_resource_data        *data);
@@ -154,6 +157,7 @@
 void
 acpi_rs_dump_irq_list (
 	u8                              *route_table);
+#endif  /*  ACPI_FUTURE_USAGE  */
 
 acpi_status
 acpi_rs_get_byte_stream_start (
--- linux-2.6.10-rc1-mm4-full/drivers/acpi/resources/rsxface.c.old	2004-11-10 00:32:09.000000000 +0100
+++ linux-2.6.10-rc1-mm4-full/drivers/acpi/resources/rsxface.c	2004-11-10 00:32:32.000000000 +0100
@@ -180,7 +180,7 @@
  *              and the value of ret_buffer is undefined.
  *
  ******************************************************************************/
-
+#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_get_possible_resources (
 	acpi_handle                     device_handle,
@@ -211,6 +211,7 @@
 	return_ACPI_STATUS (status);
 }
 EXPORT_SYMBOL(acpi_get_possible_resources);
+#endif  /*  ACPI_FUTURE_USAGE  */
 
 
 /*******************************************************************************
--- linux-2.6.10-rc1-mm4-full/include/acpi/actables.h.old	2004-11-10 00:37:23.000000000 +0100
+++ linux-2.6.10-rc1-mm4-full/include/acpi/actables.h	2004-11-10 00:37:41.000000000 +0100
@@ -50,10 +50,12 @@
 #define SIZE_IN_HEADER          0
 
 
+#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_tb_handle_to_object (
 	u16                             table_id,
 	struct acpi_table_desc          **table_desc);
+#endif
 
 /*
  * tbconvrt - Table conversion routines
--- linux-2.6.10-rc1-mm4-full/drivers/acpi/tables/tbutils.c.old	2004-11-10 00:37:51.000000000 +0100
+++ linux-2.6.10-rc1-mm4-full/drivers/acpi/tables/tbutils.c	2004-11-10 00:38:30.000000000 +0100
@@ -62,7 +62,7 @@
  *              return a pointer to that table descriptor.
  *
  ******************************************************************************/
-
+#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_tb_handle_to_object (
 	u16                             table_id,
@@ -90,6 +90,7 @@
 	ACPI_DEBUG_PRINT ((ACPI_DB_ERROR, "table_id=%X does not exist\n", table_id));
 	return (AE_BAD_PARAMETER);
 }
+#endif  /*  ACPI_FUTURE_USAGE  */
 
 
 /*******************************************************************************
--- linux-2.6.10-rc1-mm4-full/drivers/acpi/tables/tbxface.c.old	2004-11-10 00:39:15.000000000 +0100
+++ linux-2.6.10-rc1-mm4-full/drivers/acpi/tables/tbxface.c	2004-11-10 00:45:05.000000000 +0100
@@ -138,6 +138,8 @@
 }
 
 
+#ifdef ACPI_FUTURE_USAGE
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_load_table
@@ -344,6 +346,8 @@
 }
 
 
+#endif  /*  ACPI_FUTURE_USAGE  */
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_get_table
--- linux-2.6.10-rc1-mm4-full/include/acpi/acutils.h.old	2004-11-10 00:47:57.000000000 +0100
+++ linux-2.6.10-rc1-mm4-full/include/acpi/acutils.h	2004-11-10 01:23:29.000000000 +0100
@@ -666,12 +666,14 @@
 	u16                             action,
 	union acpi_generic_state        **state_list);
 
+#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_ut_create_pkg_state_and_push (
 	void                            *internal_object,
 	void                            *external_object,
 	u16                             index,
 	union acpi_generic_state        **state_list);
+#endif
 
 union acpi_generic_state *
 acpi_ut_create_control_state (
@@ -730,9 +732,11 @@
 
 #define ACPI_ANY_BASE        0
 
+#ifdef ACPI_FUTURE_USAGE
 char *
 acpi_ut_strupr (
 	char                            *src_string);
+#endif
 
 u8 *
 acpi_ut_get_resource_end_tag (
@@ -851,9 +855,11 @@
 	char                            *module,
 	u32                             line);
 
+#ifdef ACPI_FUTURE_USAGE
 void
 acpi_ut_dump_allocation_info (
 	void);
+#endif
 
 void
 acpi_ut_dump_allocations (
--- linux-2.6.10-rc1-mm4-full/drivers/acpi/utilities/utalloc.c.old	2004-11-10 01:18:42.000000000 +0100
+++ linux-2.6.10-rc1-mm4-full/drivers/acpi/utilities/utalloc.c	2004-11-10 01:07:33.000000000 +0100
@@ -818,7 +818,7 @@
  * DESCRIPTION: Print some info about the outstanding allocations.
  *
  ******************************************************************************/
-
+#ifdef ACPI_FUTURE_USAGE
 void
 acpi_ut_dump_allocation_info (
 	void)
@@ -864,6 +864,7 @@
 */
 	return_VOID;
 }
+#endif  /*  ACPI_FUTURE_USAGE  */
 
 
 /*******************************************************************************
--- linux-2.6.10-rc1-mm4-full/drivers/acpi/utilities/utmisc.c.old	2004-11-10 01:23:39.000000000 +0100
+++ linux-2.6.10-rc1-mm4-full/drivers/acpi/utilities/utmisc.c	2004-11-10 01:24:00.000000000 +0100
@@ -488,7 +488,7 @@
  * DESCRIPTION: Convert string to uppercase
  *
  ******************************************************************************/
-
+#ifdef ACPI_FUTURE_USAGE
 char *
 acpi_ut_strupr (
 	char                            *src_string)
@@ -508,6 +508,7 @@
 
 	return (src_string);
 }
+#endif  /*  ACPI_FUTURE_USAGE  */
 
 
 /*******************************************************************************
--- linux-2.6.10-rc1-mm4-full/include/acpi/platform/acenv.h.old	2004-11-10 01:22:23.000000000 +0100
+++ linux-2.6.10-rc1-mm4-full/include/acpi/platform/acenv.h	2004-11-10 01:23:01.000000000 +0100
@@ -223,7 +223,11 @@
  */
 
 #define ACPI_STRSTR(s1,s2)      strstr((s1), (s2))
+
+#ifdef ACPI_FUTURE_USAGE
 #define ACPI_STRUPR(s)          (void) acpi_ut_strupr ((s))
+#endif
+
 #define ACPI_STRLEN(s)          (acpi_size) strlen((s))
 #define ACPI_STRCPY(d,s)        (void) strcpy((d), (s))
 #define ACPI_STRNCPY(d,s,n)     (void) strncpy((d), (s), (acpi_size)(n))
@@ -287,7 +291,11 @@
 
 
 #define ACPI_STRSTR(s1,s2)      acpi_ut_strstr ((s1), (s2))
+
+#ifdef ACPI_FUTURE_USAGE
 #define ACPI_STRUPR(s)          (void) acpi_ut_strupr ((s))
+#endif
+
 #define ACPI_STRLEN(s)          (acpi_size) acpi_ut_strlen ((s))
 #define ACPI_STRCPY(d,s)        (void) acpi_ut_strcpy ((d), (s))
 #define ACPI_STRNCPY(d,s,n)     (void) acpi_ut_strncpy ((d), (s), (acpi_size)(n))
--- linux-2.6.10-rc1-mm4-full/drivers/acpi/utilities/utxface.c.old	2004-11-10 01:25:34.000000000 +0100
+++ linux-2.6.10-rc1-mm4-full/drivers/acpi/utilities/utxface.c	2004-11-10 01:28:11.000000000 +0100
@@ -343,6 +343,8 @@
 }
 
 
+#ifdef ACPI_FUTURE_USAGE
+
 /*****************************************************************************
  *
  * FUNCTION:    acpi_subsystem_status
@@ -491,6 +493,8 @@
 	return AE_OK;
 }
 
+#endif  /*  ACPI_FUTURE_USAGE  */
+
 
 /*****************************************************************************
  *
--- linux-2.6.10-rc1-mm4-full/drivers/acpi/resources/Makefile.old	2004-11-10 00:29:46.000000000 +0100
+++ linux-2.6.10-rc1-mm4-full/drivers/acpi/resources/Makefile	2004-11-10 00:30:37.000000000 +0100
@@ -3,6 +3,8 @@
 #
 
 obj-y := rsaddr.o  rscreate.o  rsio.o   rslist.o    rsmisc.o   rsxface.o \
-	 rscalc.o  rsdump.o    rsirq.o  rsmemory.o  rsutils.o
+	 rscalc.o  rsirq.o  rsmemory.o  rsutils.o
+
+obj-$(ACPI_FUTURE_USAGE) += rsdump.o
 
 EXTRA_CFLAGS += $(ACPI_CFLAGS)
--- linux-2.6.10-rc1-mm4-full/drivers/acpi/hardware/hwgpe.c.old	2004-11-10 01:56:43.000000000 +0100
+++ linux-2.6.10-rc1-mm4-full/drivers/acpi/hardware/hwgpe.c	2004-11-10 01:57:18.000000000 +0100
@@ -135,7 +135,7 @@
  * DESCRIPTION: Return the status of a single GPE.
  *
  ******************************************************************************/
-
+#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_hw_get_gpe_status (
 	struct acpi_gpe_event_info      *gpe_event_info,
@@ -194,6 +194,7 @@
 unlock_and_exit:
 	return (status);
 }
+#endif  /*  ACPI_FUTURE_USAGE  */
 
 
 /******************************************************************************
--- linux-2.6.10-rc1-mm4-full/drivers/acpi/resources/rsutils.c.old	2004-11-10 02:00:10.000000000 +0100
+++ linux-2.6.10-rc1-mm4-full/drivers/acpi/resources/rsutils.c	2004-11-10 02:00:33.000000000 +0100
@@ -175,7 +175,7 @@
  *              and the contents of the callers buffer is undefined.
  *
  ******************************************************************************/
-
+#ifdef ACPI_FUTURE_USAGE
 acpi_status
 acpi_rs_get_prs_method_data (
 	acpi_handle                     handle,
@@ -210,6 +210,7 @@
 	acpi_ut_remove_reference (obj_desc);
 	return_ACPI_STATUS (status);
 }
+#endif  /*  ACPI_FUTURE_USAGE  */
 
 
 /*******************************************************************************
